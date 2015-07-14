PortScan 1.0.1 for mIRC 5.6+
© Copyright 1999 by WD_40, All rights reserved

type " /load -rs <path>\portscan-1.0.1.mrc " to load this script

Read the README.txt if you have any questions on how to use this
script!  It's the equivalent of a help file, and I didn't write it
just to amuse myself. :p

I'd like to give special thanks to Stevie-O who helped me quite
a bit with finding bugs and fixing them.
And thanks to nintsu who gave me several good ideas for features,
and for letting me fill up his connection logs with all my
never-ending scans :)
----------------------------------
;menu menubar { 
;  PortScan 1.0.1:scan 
;}
alias scan {
  if ($dialog(scanner)) { dialog -v scanner | return }
  dialog -md scanner pscan
}
dialog pscan {
  size -1 -1 340 315
  title "PortScan"
  check "&5 Resolve Hostnames",24,120 107 130 20,left
  check "&6 Common Ports Only",25,120 125 130 20,left
  button "&SCAN",1,260 1 70 25,default
  button "&HALT",2,260 29 70 25,ok
  button "SA&VE",3,260 58 70 25,ok
  button "&RESET",4,260 87 70 25,ok
  button "&PORTS...",55,260 116 70 25,ok
  button "",26,1 1 1 1,cancel
  text "Scan: ",5,10 5 30 25,left
  edit "localhost",6,40 1 210 25,left
  text "Send Port:",71,12 33 52 23,right
  edit "0",70,70 30 55 23,left
  text "Stop Port:",81,12 60 52 23,right
  edit "0",7,195 30 55 23,left
  text "Recv Port:",8,142 33 52 23,right
  edit "20",9,195 57 55 23,left
  edit "65535",90,70 57 55 23,left
  text "Delay (MS):",10,140 62 55 23,left
  edit "0",11,195 85 55 23,left
  text "Open Sockets:",12,123 91 72 18,left
  check "1 Quick Scan",13,8 81 105 23,left
  check "&2 Reset on halt",14,8 99 105 23,left
  check "&3 Save on halt",15,8 118 105 23,left
  check "&4 Close IRC Ports",27,8 137 105 23,left
  list 16,10 165 325 145,vsbar
  ;  text "Scan Results:",17,10 150 75 15,left
  button "&Clear Results",18,120 145 100 20,left
  button "&About...",19,230 145 103 20,left
  button "Filename:",20,7 291 50 20,left
  edit "",21,57 288 210 25,autohs
  check "&Overwrite",22,268 294 65 15,right
}

dialog about {
  size -1 -1 220 170
  title "PortScan for Qrude OiL"
  button "Yup, that's nice",1,65 140 85 25,ok
  text "PortScan v1.0.1 for Qrude OiL",2,35 5 150 25,center
  text "-Thanks to all my Beta testers-",3,35 33 150 25,center
  text "Stevie-O, nintsu, Rappy",6,35 47 150 25,center
  text "  © Copyright 1999 by WD_40, All rights reserved",4,25 70 150 25,center
  button "http://members.xoom.com/Qrude/portscan",5,7 105 210 20,center
}
on 1:dialog:about:sclick:5: { run $did(about,5).text | did -f about 1 }

dialog err0r {
  title "Error"
  size -1 -1 150 85
  text "The Log File Does Not Exist",2,6 20 140 50
  button "My Bad",1,45 50 55 25,ok
}

on 1:dialog:scanner:init:0: {
  did -m scanner 7,11
  did -o scanner 21 1 $scriptdirportscan.txt
  did -f scanner 6
  did -i scanner 16 1 0 $STR($CHR(160),2) $+ :PortScan Ready
  did -c scanner 24
  did -b scanner 2
  .enable #scan.verbose
}
on 1:dialog:scanner:sclick:1: {
  unset %i
  unset %port
  unset %stop.port
  did -b scanner 1
  did -e scanner 2
  sockclose scan_*
  did -o scanner 11 1 0
  if ($did(70).text > 65535) { did -o scanner 70 1 65535 }
  if ($did(70).text !isnum) { did -o scanner 70 1 1 }
  if ($did(90).text !isnum) { did -o scanner 90 1 65535 }
  if ($did(25).state == 1) { did -om scanner 90 1 Not Used }
  if ($did(90).text < $did(70).text) did -o scanner 90 1 $did(70).text
  if ($longip($did(6).text) == $null) {
    .enable #dnscatcher
    .dns -h $did(6).text
  }
  did -i scanner 16 $calc($did(16).lines + 1) 0 $str($chr(160),2) $+ :SCANNING HOST: $+ $did(6).text
  did -i scanner 16 $calc($did(16).lines + 1) 0 $str($chr(160),2) $+ :SCAN BEGUN ON PORT: $+ $did(70).text
  if ($did(24).state == 0) did -i scanner 16 $calc($did(scanner,16).lines + 1) 0 $str($chr(160),2) $+ :IP: $+ $did(6).text
  if ($did(70) == 0) did -o scanner 70 1 1
  if ($did(scanner,25).state == 0) { set %port $did(scanner,70).text }
  if ($did(scanner,25).state == 1) { set %port $gettok( [ $read -l1 $scriptdircommon-ports.txt ] ,1,32) }
  set %i -l1
  if (($left($did(6).text,1) isnum) && ($numtok($did(6).text,46) == 4)) scanner.scan
}
on 1:dialog:scanner:sclick:2: {
  did -b scanner 2
  did -e scanner 1
  did -f scanner 1
  did -i scanner 16 $calc($did(16).lines + 1) 0 $str($chr(160),2) $+ :SCAN HALTED ON PORT: $+ $did(scanner,70).text
  if ($did(14).state == 1) { scanner.reset }
  if ($did(15).state == 1) { scanner.write }
}

on 1:dialog:scanner:sclick:3: {
  scanner.write
}

on 1:dialog:scanner:sclick:4: {
  scanner.reset
  halt
}

on 1:dialog:scanner:edit:6: {
  if ($left($did(6).text,1) isletter) did -c scanner 24
  if ($left($did(6).text,1) isnum) did -u scanner 24
}
on 1:dialog:scanner:sclick:13: {
  if ($did(scanner,13).state == 1) .disable #scan.verbose
  if ($did(scanner,13).state == 0) .enable #scan.verbose
}
on 1:dialog:scanner:sclick:18: did -r scanner 16
on 1:dialog:scanner:sclick:19: { dialog -md about about }
on 1:dialog:scanner:sclick:20: { 
  did -f scanner 1
  if ($exists($did(21).text) == $false) { dialog -mo wups err0r | halt }
  run $did(21).text
}
on 1:dialog:scanner:sclick:25: {
  if ($did(25).state == 1) {
    did -om scanner 70 1 $gettok( [ $read -l1 $scriptdircommon-ports.txt ] ,1,32)
    did -om scanner 90 1 Not Used
  }
  if ($did(25).state == 0) {
    did -on scanner 70 1 1
    did -on scanner 90 1 65535
  }
}
on 1:dialog:scanner:sclick:26: { did -e scanner 2 | sockclose scan_* }
on 1:dialog:scanner:sclick:55: run $scriptdircommon-ports.txt | halt
#dnscatcher off
on 1:dns:{
  if ($iaddress == $null) {
    did -o scanner 6 1 Invalid Address
    did -i scanner 16 $calc($did(scanner,16).lines + 1) 0 $str($chr(160),2) $+ :IP:Invalid IP - SCAN HALTED
    did -b scanner 2
    did -e scanner 1
    halt 
  }
  if ($iaddress != $null) {
    did -o scanner 6 1 $iaddress
    did -i scanner 16 $calc($did(scanner,16).lines + 1) 0 $str($chr(160),2) $+ :IP: $+ $iaddress
    .disable #dnscatcher
    scanner.scan
    halt
  }
}
#dnscatcher end

-----------
  Aliases 
-----------
alias scanner.reset {
  did -i scanner 16 $calc($did(scanner,16).lines + 1) 0 $str($chr(160),2) $+ :RESET - ALL SOCKETS CLOSED
  sockclose scan_*
  did -o scanner 11 1 0
}
alias scanner.write {
  if ($did(scanner,21).text == $null) halt
  if ($did(Scanner,22).state == 1) .remove $did(scanner,21)
  var %i = 1
  var %stop = $did(16).lines
  :lewp
  write $did(scanner,21) $did(scanner,16,%i)
  inc %i 1
  if (%i > %stop) goto end
  goto lewp
  :end
}

alias scanner.scan {
  if ($dialog(scanner) == $null) goto abort
  if ($did(scanner,2).enabled == $false) goto end
  if ($did(scanner,25).state == 0) {
    set %stop.port $did(scanner,90).text
    did -o scanner 70 1 %port
    sockopen scan_ $+ $did(scanner,70).text $did(scanner,6).text $did(scanner,70).text
    did -o scanner 11 1 $calc($did(scanner,11).text + 1)
    inc %port 1
    if (%port > %stop.port) goto end
    if ($did(scanner,9).text == $null) { did -o scanner 9 1 20 }
    scanner.loop
    halt
  }
  if ($did(scanner,25).state == 1) {
    set %stop.port $lines($scriptdircommon-ports.txt)
    did -o scanner 70 1 %port
    sockopen scan_ $+ %port $did(scanner, 6).text %port
    did -o scanner 11 1 $calc($did(scanner,11).text + 1)
    set %i -l $+ $calc($right(%i,$calc($len(%i) - 2)) + 1)
    set %port $gettok( [ $read %i $scriptdircommon-ports.txt ] ,1,32)
    if ($right(%i,$calc($len(%i) - 2)) == %stop.port) goto end
    if ($did(scanner,9).text == $null) { did -o scanner 9 1 20 }
    scanner.loop
    halt
  }
  :end
  if ($did(scanner,13).state == 1) scanner.reset
  did -e scanner 1
  did -b scanner 2
  :abort
}
alias scanner.loop .timer -m 1 $did(scanner,9).text scanner.scan
alias scanner.badip {
  did -i scanner 16 $calc($did(scanner,16).lines + 1) 0 $str($chr(160),2) $+ :IP:Invalid IP - SCAN HALTED
  did -f scanner 6
  did -b scanner 2
  did -e scanner 1
  halt
}
-------------
Socket Events
-------------
on 1:sockopen:scan_*: {
  if ($sock($sockname).status == active) {
    if ($read -w $+ $gettok($sockname,2,95) $+ * $scriptdircommon-ports.txt == $null) {
      did -i scanner 16 $calc($did(scanner,16).lines + 1) $gettok($sockname,2,95) $str($chr(160),2) $+ :CONNECT
    }
    if ($read -w $+ $gettok($sockname,2,95) $+ * $scriptdircommon-ports.txt != $null) {
      did -i scanner 16 $calc($did(scanner,16).lines + 1) $gettok($sockname,2,95) $str($chr(160),2) $+ :CONNECT $str($chr(160),5) $+ $gettok( [ $read -w $gettok($sockname,2,95) $+ * $scriptdircommon-ports.txt ] ,2,32)
    }
    did -o scanner 7 1 $gettok($sockname,2,95)
    if ($did(scanner,13).state == 1) { 
      sockclose $sockname
      did -o scanner 11 1 $calc($did(scanner,11).text - 1)
    }
  }
  if ($sock($sockname).status == Connecting) {
    did -o scanner 11 1 $calc($did(scanner,11).text - 1)
  }
  if ($did(scanner,14).state == 1) && ($gettok($sockname,2,95) == $did(scanner,90)) {
    scanner.reset
  }
}

on 1:sockclose:scan_*: {
  did -i scanner 16 $calc($did(scanner,16).lines + 1) $gettok($sockname,2,95) $str($chr(160),2) $+ :CLOSED
  did -o scanner 11 1 $calc($did(scanner,11).text - 1)
}

#scan.verbose on
on 1:sockread:scan_*: {
  if ($sockerr > 0) return
  :nextread
  sockread %temp
  if ($sockbr == 0) return
  if (%temp == $null) %temp = -
  if ($did(scanner,27).state == 1) {
    if (AUTH isincs %temp) {
      sockclose $sockname
      did -o scanner 11 1 $calc($did(scanner,11).text - 1)
      return
    }
  }
  did -i scanner 16 $calc($did(scanner,16).lines + 1) $gettok($sockname,2,95) $str($chr(160),2) $+ : $+ %temp
  goto nextread
}
#scan.verbose end
