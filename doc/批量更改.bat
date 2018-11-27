@echo off & color 3a & setlocal enabledelayedexpansion
title 批量替换文件(文件夹)名
echo 此批处理可批量替换本文件所在文件夹下所有文件(文件夹)名。
echo.
set str1=_zh_CN
set str2=_en_US
echo.
echo 正在替换文件名……
for /f "delims=" %%a in ('dir /a-d /s /b') do (
if "%%~nxa" neq "%~nx0" (
set "f=%%~na"
set "f=!f:%str1%=%str2%!"
if not exist "%%~dpa!f!%%~xa" ren "%%a" "!f!%%~xa"
)
)
echo 替换文件名完成