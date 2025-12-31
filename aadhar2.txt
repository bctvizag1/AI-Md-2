0704_Admin3
SARKhZ1PWS


KAwJHEQEfD

net stop "AADHAAR Camera Vendor Device Manager"
net stop "aouc"
net stop "mpdm"
net stop "qssitvs"

cd "c:\UID Authority of India\Aadhaar Enrolment Client\data"
ren lvs "lvs_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%"

md lvs


cd "c:\UID Authority of India\Aadhaar Enrolment Client\data"
ren packets-auto "packetsauto_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%"

md packets-auto


net start "qssitvs"
net start "mpdm"
net start "aouc"
net start "AADHAAR Camera Vendor Device Manager"


wevtutil qe System /q:"*[System[(EventID=6008)]]" /c:5 /f:text /rd:true | find "unexpected"

net start "aouc"
net start "qssitvs"
net start "mpdm"
net start "AADHAAR Camera Vendor Device Manager"

cd derbydb\runtime

explorer .







