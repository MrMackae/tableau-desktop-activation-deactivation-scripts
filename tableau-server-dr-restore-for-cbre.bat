@echo OFF

set VERSION=10.3
:: Please customise this to the version of Tableau Server you are running.
 
set "BINPATH=E:\Program Files\Tableau\Tableau Server\%VERSION%\bin"
:: In case you don't have tabadmin set in your Path environment variable, this command sets the path to the Tableau Server bin directory in order to use the tabadmin command.
:: Customise this to match your the path of your Tableau Server installation. The version variable above is included.

set "LOGPATH=E:\Logs"
:: This command sets the path to the log files folder
:: Change this to match the location of the folder you would like to save your zipped log files to

set "RESTOREPATH=E:\Backups"

set "PASSWORDFILE=E:\path\to\password-file.txt"

echo %date% %time%: Cleaning out old backup files...

forfiles -p %RESTOREPATH% -s -m *.tsbak /D -5 /C "cmd /c del @path"
:: Cleans out files in the specified directory that end in .tsbak extension and are older than 5 days
forfiles -p %LOGPATH% -s -m restore.log /C "cmd /c del @path"
:: Empties the restore.log file prior to each run

echo %date% %time%: Starting Tableau DR Server Restore...
cd /d %BINPATH%
tabadmin restore --no-config %RESTOREPATH%\ts_prod_backup-%date%.tsbak --password-file %PASSWORDFILE% >> %LOGPATH%\restore.log 2>&1

:Start
echo %date% %time%: Restore complete, starting DR Server...
tabadmin start

:End
echo %date% %time% : *** Tableau DR Server Restore Script complete ***
EXIT /b