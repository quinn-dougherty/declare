# hdmi-audio-report — snapshot every layer between the GPU and the TV.
#
# Read it top-down: the first section that looks wrong is the one to fix.
# Layers, in the order the signal travels:
#   DRM connector (is the link up?)
#     -> EDID       (does the TV *claim* it can do audio?)
#       -> ELD      (did the kernel manage to read that claim back?)
#         -> ALSA   (did an HDMI PCM device get created?)
#           -> HDA codec pin (is the pin driven?)
#             -> PipeWire (is there a sink, and is it routed/unsuspended?)

bold=$'\033[1m'
dim=$'\033[2m'
reset=$'\033[0m'

section() { printf '\n%s== %s ==%s\n' "$bold" "$*" "$reset"; }
note() { printf '%s   -> %s%s\n' "$dim" "$*" "$reset"; }
have() { command -v "$1" >/dev/null 2>&1; }

printf '%shdmi-audio-report%s  %s on %s\n' "$bold" "$reset" "$(date -Is)" "$(hostname)"

# ---------------------------------------------------------------- 1. DRM link
section "1. DRM connectors — is the TV link even up?"
for conn in /sys/class/drm/card*-*; do
  [ -e "$conn/status" ] || continue
  printf '%-26s status=%-12s enabled=%-9s dpms=%-4s top-mode=%s\n' \
    "$(basename "$conn")" \
    "$(cat "$conn/status" 2>/dev/null)" \
    "$(cat "$conn/enabled" 2>/dev/null || echo '?')" \
    "$(cat "$conn/dpms" 2>/dev/null || echo '?')" \
    "$(head -n1 "$conn/modes" 2>/dev/null || echo '-')"
done
note "HDMI audio exists only while the connector is 'connected' AND has an active mode."
note "dpms=Off, a blanked screen, or the TV switched to another input can make the"
note "sink vanish from PipeWire entirely — that looks identical to 'no audio'."

# ------------------------------------------------------------------- 2. EDID
section "2. EDID — does the TV advertise audio at all?"
edid_found=0
for conn in /sys/class/drm/card*-*; do
  [ -s "$conn/edid" ] || continue
  edid_found=1
  printf '\n%s-- %s --%s\n' "$bold" "$(basename "$conn")" "$reset"
  if have edid-decode; then
    edid-decode "$conn/edid" 2>/dev/null |
      grep -iE 'Manufacturer|Display Product Name|Audio Data Block|Speaker Allocation|Linear PCM|Basic audio|Source Physical Address|^ +[A-Z]+:? +[0-9]+ channels' |
      sed 's/^ */    /'
  else
    note "edid-decode not on PATH"
  fi
done
[ "$edid_found" = 1 ] || note "no non-empty EDID anywhere — nothing is plugged in, or the read failed."
note "No 'Audio Data Block' / 'Basic audio' means the TV is not offering audio on this"
note "input. Some sets only publish audio on specific ports (e.g. the ARC/eARC one)."

# -------------------------------------------------------------------- 3. ELD
section "3. ELD — what the kernel actually read back from the sink"
eld_found=0
for eld in /proc/asound/card*/eld#*; do
  [ -e "$eld" ] || continue
  eld_found=1
  printf '\n%s-- %s --%s\n' "$bold" "$eld" "$reset"
  grep -E 'monitor_present|eld_valid|monitor_name|connection_type|sad_count|^sad[0-9]' "$eld" |
    sed 's/^/    /'
done
if [ "$eld_found" != 1 ]; then
  note "no ELD nodes at all — the HDA HDMI codec never bound. Jump to sections 4 and 8."
fi
note "monitor_present=1 + eld_valid=0 is THE classic failure: link is up, but the ELD"
note "read over the DDC/AUX channel failed, so the port is reported unavailable and"
note "PipeWire hides or refuses the sink. Cable, TV input, or a DP->HDMI adapter that"
note "doesn't forward DDC are the usual culprits."
note "eld_valid=1 with sad_count=0 means the TV answered but claims no audio formats."

# ------------------------------------------------------------------- 4. ALSA
section "4. ALSA cards and HDMI PCM devices"
cat /proc/asound/cards 2>/dev/null | sed 's/^/    /'
echo
if have aplay; then
  aplay -l 2>/dev/null | sed 's/^/    /'
else
  note "aplay not on PATH"
fi
note "Each HDMI PCM (device 3/7/8/9...) corresponds to one connector from section 1."
note "Connector-to-PCM mapping is NOT positional — confirm it with section 5."

# -------------------------------------------------------------- 5. codec pins
section "5. HDA codec pins — which pin drives which PCM"
for codec in /proc/asound/card*/codec#*; do
  [ -e "$codec" ] || continue
  grep -qiE 'HDMI|DisplayPort' "$codec" || continue
  printf '\n%s-- %s: %s --%s\n' "$bold" "$codec" \
    "$(grep -m1 '^Codec:' "$codec" | cut -d: -f2- | sed 's/^ *//')" "$reset"
  grep -E 'Device: name=|Pin-ctls:|Pincap|Connection: ' "$codec" | sed 's/^/    /' | head -60
done
note "Pin-ctls with OUT unset on the pin you expect means the pin is not being driven."

# --------------------------------------------------------------- 6. PipeWire
section "6. PipeWire / WirePlumber graph"
if [ "$(id -u)" = 0 ]; then
  note "running as root: PipeWire is a per-user session, so sections 6-7 will be empty."
  note "re-run as the logged-in desktop user (no sudo) to see the real graph."
fi
if have wpctl && [ -n "${XDG_RUNTIME_DIR:-}" ]; then
  wpctl status 2>&1 | sed 's/^/    /'
else
  note "no wpctl or no XDG_RUNTIME_DIR — run this as the desktop user."
fi
note "PipeWire is per-user and socket-activated: on a box that is mostly a server,"
note "if nobody is logged in graphically there is no PipeWire at all and therefore"
note "no HDMI sink. Check with:  systemctl --user status pipewire wireplumber"
note "(loginctl enable-linger <user> is the fix if you want it up without a login.)"

# ------------------------------------------------- 7. profiles / availability
section "7. Card profiles, ports and sinks (PulseAudio view)"
if have pactl; then
  printf '\n%s-- cards --%s\n' "$bold" "$reset"
  pactl list cards 2>/dev/null |
    grep -E '^\s*(Name|Active Profile):|^\s+(output|input):.*\(' |
    sed 's/^\s*/    /'
  printf '\n%s-- ports and their availability --%s\n' "$bold" "$reset"
  pactl list cards 2>/dev/null |
    grep -E 'Ports:|hdmi.*:|availability' -A0 |
    grep -iE 'hdmi' |
    sed 's/^\s*/    /'
  printf '\n%s-- sinks --%s\n' "$bold" "$reset"
  pactl list sinks 2>/dev/null |
    grep -E '^\s*(Name|State|Description|Active Port):' |
    sed 's/^\s*/    /'
  printf '\n%s-- default sink --%s\n' "$bold" "$reset"
  printf '    %s\n' "$(pactl get-default-sink 2>/dev/null)"
else
  note "pactl not on PATH"
fi
note "A port marked 'not available' traces straight back to section 3's ELD."
note "An HDMI card sitting on profile 'off' means nothing ever selected it."

# ---------------------------------------------------------------- 8. dmesg
section "8. Kernel messages"
if dmesg >/dev/null 2>&1; then
  dmesg --color=never 2>/dev/null |
    grep -iE 'hdmi|snd_hda|azalia|i915|xe |sof-|ELD|hdaudio' |
    tail -40 | sed 's/^/    /'
else
  note "dmesg is restricted for non-root; try:  journalctl -k | grep -iE 'hdmi|snd_hda|i915'"
fi

# ------------------------------------------------------------- 9. next steps
section "9. What to try next"
cat <<'EOF'
    Bisect PipeWire out of the picture — play a tone straight at ALSA:
        speaker-test -D plughw:CARD=<card>,DEV=<dev> -c 2 -t sine -l 1
      using the CARD/DEV names from section 4. If this makes noise but apps
      don't, the fault is PipeWire routing, not the TV, cable or kernel.

    Force the profile and the default sink:
        pactl list cards short
        pactl set-card-profile <card> output:hdmi-stereo
        wpctl status && wpctl set-default <sink-id>

    Watch the link live while you replug the cable or switch TV input:
        journalctl -kf | grep -iE 'hdmi|eld|snd_hda'

    If section 3 shows eld_valid=0:
      - power-cycle the TV, reseat the cable, try a different HDMI input
      - try a different cable; a marginal one can carry video but drop DDC
      - on a Framework, try a different USB-C port for the HDMI expansion card,
        and check `fwupdmgr get-devices` for expansion-card firmware

    If section 1 shows 'connected' but section 4 shows no HDMI PCM at all, the
    audio codec never bound — look for i915/snd_hda_intel errors in section 8.
EOF
echo
