@echo OFF

:: Variables section - please customise these to your environment

set TABVERSION=24.2
set TABINSTALLPATH=C:\Program Files\Tableau\Tableau %TABVERSION%\bin
set TABPRODUCTKEY=XXXX-XXXX-XXXX-XXXX-XXXX
set TABREGFILEPATH=C:\temp\TableauRegistration.reg

:: End of Variables section

echo Activating Tableau Desktop...
cd /d %TABINSTALLPATH%
start/wait tableau.exe -activate  %TABPRODUCTKEY%

if %errorlevel% EQU 0 (ECHO SUCCESS: Activation completed successfully.)
if %errorlevel% EQU 536871012 (ECHOTABLEAU_ERROR_LICENSING_GENERAL: An unknown error occurred during the licensing operation.)
if %errorlevel% EQU 536871013 (ECHOTABLEAU_ERROR_LICENSING_INTERNAL: The product is unable to start due to an internal licensing error.)
if %errorlevel% EQU 536871014 (ECHOTABLEAU_ERROR_LICENSING_SETUP: The product is unable to start due to an internal licensing error.)
if %errorlevel% EQU 536871015 (ECHOTABLEAU_ERROR_LICENSING_CONNECT: An error occurred contacting the Tableau license server.)
if %errorlevel% EQU 536871017 (ECHOTABLEAU_ERROR_LICENSING_ACTIVATION_ASR: An error occurred while activating the ASR.)
if %errorlevel% EQU 536871016 (ECHOTABLEAU_ERROR_LICENSING_ACTIVATION_GENERAL: Activation failed, please try again.)
if %errorlevel% EQU 536871018 (ECHOTABLEAU_ERROR_LICENSING_ACTIVATION_INVALID_KEY: Invalid product key.)
if %errorlevel% EQU 536871019 (ECHOTABLEAU_ERROR_LICENSING_ACTIVATION_OFFLINE: Unable to complete offline activation.)
if %errorlevel% EQU 536871020 (ECHOTABLEAU_ERROR_LICENSING_ACTIVATION_INVALID_MODEL: An error was returned from the license server. Check the Tableau log file for more information.)
if %errorlevel% EQU 536871021 (ECHOTABLEAU_ERROR_LICENSING_ACTIVATION_MAX_REHOSTS: Failed to deactivate the license because you have reached the limit of deactivations for this license.)
if %errorlevel% EQU 536871022 (ECHOTABLEAU_ERROR_LICENSING_UNLICENSED_GENERAL: An unknown error occurred during the unlicensing operation. Check your product key or contact support.)
if %errorlevel% EQU 536871023 (ECHOTABLEAU_ERROR_LICENSING_UNLICENSED_NONE_FOUND: No licenses found.)
if %errorlevel% EQU 536871024 (ECHOTABLEAU_ERROR_LICENSING_UNLICENSED_EXPIRED: Only expired product keys were found.)
if %errorlevel% EQU 536871025 (ECHOTABLEAU_ERROR_LICENSING_UNLICENSED_EXPIRED_TRIAL: Your trial for this version has ended.)
if %errorlevel% EQU 536871026 (ECHOTABLEAU_ERROR_LICENSING_UNLICENSED_EXPIRED_SUBSCRIPTION: The product key is expired.)
if %errorlevel% EQU 536871027 (ECHOTABLEAU_ERROR_LICENSING_UNLICENSED_EXPIRED_MAINTENANCE: Maintenance has expired.)
if %errorlevel% EQU 536871028 (ECHOTABLEAU_ERROR_LICENSING_RESYNC_GENERAL: Your product keys could not be synchronized.)
if %errorlevel% EQU 536871029 (ECHOTABLEAU_ERROR_LICENSING_REGISTRATION_GENERAL: An error occurred during product registration.)
if %errorlevel% EQU 536871030 (ECHOTABLEAU_ERROR_LICENSING_SERVICE_INSTALL: An unknown error occurred during licensing operations.)
if %errorlevel% EQU 536871031 (ECHOTABLEAU_ERROR_LICENSING_SERVICE_UNINSTALL: An unknown error occurred during licensing operations.)

echo Populating Registry with Registration Information...
REG IMPORT  "%TABREGFILEPATH%"
echo Registry population complete

echo Registering Tableau Desktop...
cd /d %TABINSTALLPATH%
start/wait tableau.exe -register
echo Tableau Desktop registration complete
