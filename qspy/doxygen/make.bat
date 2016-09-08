@echo off
:: ==========================================================================
:: Product: QSPY script for generating Doxygen documentation
:: Last Updated for Version: 5.7.0
:: Date of the Last Update:  2016-09-08
::
::                    Q u a n t u m     L e a P s
::                    ---------------------------
::                    innovating embedded systems
::
:: Copyright (C) Quantum Leaps, LLC. All rights reserved.
::
:: This program is open source software: you can redistribute it and/or
:: modify it under the terms of the GNU General Public License as published
:: by the Free Software Foundation, either version 3 of the License, or
:: (at your option) any later version.
::
:: Alternatively, this program may be distributed and modified under the
:: terms of Quantum Leaps commercial licenses, which expressly supersede
:: the GNU General Public License and are specifically designed for
:: licensees interested in retaining the proprietary status of their code.
::
:: This program is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY; without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
:: GNU General Public License for more details.
::
:: You should have received a copy of the GNU General Public License
:: along with this program. If not, see <http://www.gnu.org/licenses/>.
::
:: Contact information:
:: http://www.state-machine.com
:: mailto:info@state-machine.com
:: ==========================================================================
setlocal

echo usage:
echo make
echo make -CHM

set VERSION=5.7.0

set DOXHOME="C:\tools\doxygen\bin"

:: Generate Doxygen Documentation ........................................... 
if "%1"=="-CHM" (
    echo Generating HTML...
    ::( type Doxyfile & echo GENERATE_HTMLHELP=YES ) | %DOXHOME%\doxygen.exe -
    %DOXHOME%\doxygen.exe Doxyfile-CHM
    
    echo Adding custom images...
    xcopy preview.js tmp\
    xcopy img tmp\img\
    echo img\img.htm >> tmp\index.hhp

    echo Generate CHM...
    "C:\tools\HTML Help Workshop\hhc.exe" tmp\index.hhp
    
    echo Cleanup...
    rmdir /S /Q  tmp
    echo CHM file generated in ../../../html/qspy.chm

) else (
    echo Cleanup...
    rmdir /S /Q  ..\..\..\html\qspy
    
    echo Adding custom images...
    xcopy preview.js ..\..\..\html\qspy\
    xcopy img ..\..\..\html\qspy\img\
    copy images\favicon.ico ..\..\..\html\qspy

    echo Generating HTML...
    %DOXHOME%\doxygen.exe Doxyfile
)

endlocal
