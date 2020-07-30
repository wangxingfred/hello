@echo off
REM change CHCP to UTF-8
CHCP 65001 > nul

protoc.exe -I . --python_betterproto_out=. all_in_one.proto

ping -n 2 127.0.0.1 >nul