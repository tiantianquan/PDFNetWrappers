@echo off
setlocal
set TEST_NAME=PageLabelsTest
SET PATH=..\..\..\PDFNetC\Lib;%PATH%
ruby.exe %TEST_NAME%.rb
endlocal
