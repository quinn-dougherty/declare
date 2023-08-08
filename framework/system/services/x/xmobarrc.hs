Config { font = "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*"
       , bgColor = "black"
       , fgColor = "yellow"
       , position = TopW L 100
       , commands = [ Run Weather "EGPF" ["-t","<tempF>F","-L","64","-H","77","--normal","green","--high","red","--low","lightblue"] 36000
                    , Run DynNetwork     [ "--template" , "<dev>: UP=<tx>kB/s * DOWN=<rx>kB/s"
                                         , "--Low"      , "3750"
                                         , "--High"     , "10000"
                                         , "--low"      , "darkgreen"
                                         , "--normal"   , "darkorange"
                                         , "--high"     , "darkred"
                                         ] 10

                    , Run MultiCpu ["-t","Cpu: <total0>% * <total1>% * <total2>% * <total3>% * <total4>% * <total5>% * <total6>% * <total7>%"
                                   ,"-L","3"
                                   ,"-H","50"
                                   ,"--normal","green"
                                   ,"--high","red"
                                   ] 10
                    , Run Memory ["-t","Mem: <usedratio>%"] 10
                    , Run Swap [] 10
                    , Run BatteryP ["/sys/class/power_supply/BAT1"] [ "--template", "<acstatus>"
                                  , "--Low", "10"
                                  , "--High", "80"
                                  , "--low", "darkred"
                                  , "--normal", "darkorange"
                                  , "--high", "darkgreen"
                                  , "--"
                                  , "-O", "<left>% <fc=darkgreen>↻</fc>"
                                  , "-i", "<fc=darkgreen>∞</fc>"
                                  , "-o", "<left>% (<timeleft>)"
                                  ] 1000
                    , Run Date "%a %b %_d %H:%M:%S" "date" 10
                    , Run Com "getMasterVolume" [] "volumelevel" 10
                    , Run StdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "%StdinReader% }{ %volumelevel%    |    %dynnetwork%    |    %multicpu%    |    %memory% * %swap%    |    %battery%    |    %date%    |    %EGPF%"
       , allDesktops = True
       }
