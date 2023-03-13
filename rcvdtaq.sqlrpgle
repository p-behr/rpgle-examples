**free

ctl-opt dftactgrp(*no) actgrp('RCVDTAQ');
ctl-opt option(*nodebugio : *srcstmt);
ctl-opt pgminfo(*pcml : *module);

dcl-pi *n;  // *Entry plist
end-pi;


dcl-pr rcvDtaq    extpgm('QRCVDTAQ');
  dtaqName        char(10)    const;
  dtaqLib         char(10)    const;
  dataLength      packed(5:0);
  data            char(64512) options(*varsize);
  waitSeconds     packed(5:0) const;
//   keyOrder        char(2)     const   options(*nopass);
//   keyLen          packed(3:0) const   options(*nopass);
//   keyData         char(256)   const   options(*nopass:*varsize);
//   senderLen       packed(3:0) const   options(*nopass);
//   senderInfo      char(44)    const   options(*nopass:*varsize);
//   removeMsg       char(10)    const   options(*nopass);
//   dataSize        packed(5:0) const   options(*nopass);
//   error           likeds(apiError)    options(*nopass:*varsize);
end-pr;

// dcl-ds apiError Qualified Inz;
//   bytesProvided Int(10:0) Inz(256);
//   bytesAvailable Int(10:0);
//   exceptionID Char(7);
//   reserved Char(1);
//   exceptionData Char(256);
// end-ds;

dcl-s data      char(64512);
dcl-s dataLen   packed(5);

// Check for data queue entries.
// Waits for up to 2 seconds for entry to appear...
// if none received after 2 seconds, the program will end.
dou dataLen = 0;
    rcvDtaq( 'TESTDTAQ'
           : '*LIBL'     
           : dataLen     // length of data returned
           : data        // data received
           : 2           // wait time (2 seconds)
           // : ' '         // key order
           // : 0           // key length
           // : ' '         // key data
           // : 0           // sender info length
           // : *omit       // sender info
           // : '*YES'      // remove message
           // : %size(data) // data field size
           // : apiError    // error data structure
           );

    if dataLen > 0;
        processDtaqEntry(data);
    endif;

enddo;

*inlr = *on;
return;

//==============================================================================
dcl-proc  processDtaqEntry;
    dcl-pi *n;
        in_data char(64512) const;
    end-pi;

    dcl-s data char(256);
    data = '>>> DTAQ DATA: ' + %trim(in_data);

    Exec SQL
     CALL SYSTOOLS.LPRINTF(TRIM(:data));

    return;
end-proc  processDtaqEntry;
