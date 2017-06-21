cd source


cd ..\..\zips

del "cs50.zip"

cd ..\cs50

"WinRAR.exe" a -ep1 -r -xMakefile86.bat -xMakefile.bat -xMakefile -x\.svn -x*\.svn\ -afzip "..\zips\cs50.zip"

cd source


@curl --user rokudev:1234 --digest -s -S -F "mysubmit=Install" -F "archive=@..\..\zips\cs50.zip" -F "passwd=" http://192.168.101.239/plugin_install

cd ..