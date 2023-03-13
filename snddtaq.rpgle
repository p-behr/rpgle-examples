**free

ctl-opt dftactgrp(*no) actgrp('SNDDTAQ');
ctl-opt option(*nodebugio : *srcstmt);
ctl-opt pgminfo(*pcml : *module);

dcl-pr sndDtaq    extpgm('QSNDDTAQ');
  dtaqName        char(10)    const;
  dtaqLib         char(10)    const;
  dataLength      packed(5:0) const;
  data            char(64512) const options(*varsize);
end-pr;

dcl-s i uns(5);

for i = 1 to 10;

    sndDtaq( 'TESTDTAQ'
           : '*LIBL'
           : 40
           : 'Data queue entry #' + %char(i)
           );

endfor;

*inlr = *on;
return;
