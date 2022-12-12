**free

ctl-opt dftactgrp(*no);

recursive();

*inlr = *on;
return;


dcl-proc recursive;

    dcl-s  totalCalls  uns(3) static;
    dcl-s  thisCall    uns(3);

    totalCalls += 1;
    thisCall = totalCalls;

    if thisCall < 4;
        recursive();
    endif;

end-proc;
