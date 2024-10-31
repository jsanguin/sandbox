**free
ctl-opt option(*srcstmt) dftactGrp(*no);

dcl-pr Main ExtPgm('IFSREAD');
    *n char(1024);
END-PR;

dcl-pi Main;
    rtnVal char(1024);
END-PI;
/copy ifsio_h


dcl-c IFSLOC          '/home/JSANGUIN/json/Person.txt';
dcl-s fd  int(10) inz(0);
dcl-s len int(10) inz(0);
dcl-s data   char(1024);
dcl-s error_msg    char(40);

fd = open(IFSLOC :  O_RDONLY+O_TEXTDATA);


if   fd < 0;
        // Display the error message
    dsply ('Error during open!');

    *inlr = *on;
    return;
endif;

      // Readfrom file..
len= read(fd: %addr(data): %size(data));
if (len < %size(data));
    error_msg = 'Only ' + %char(len) + ' bytes were found!';
    dsply error_msg;
endif;
rtnVal = data;
      // Close the file:
closef(fd);

*inlr = *on; 