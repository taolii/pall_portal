@echo off & color 3a & setlocal enabledelayedexpansion
title �����滻�ļ�(�ļ���)��
echo ��������������滻���ļ������ļ����������ļ�(�ļ���)����
echo.
set str1=_zh_CN
set str2=_en_US
echo.
echo �����滻�ļ�������
for /f "delims=" %%a in ('dir /a-d /s /b') do (
if "%%~nxa" neq "%~nx0" (
set "f=%%~na"
set "f=!f:%str1%=%str2%!"
if not exist "%%~dpa!f!%%~xa" ren "%%a" "!f!%%~xa"
)
)
echo �滻�ļ������