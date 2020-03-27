@echo off
================================================================================  
:: NOME   : Windows Terminal - Configurar 
:: AUTOR  : Ivo Dias
================================================================================
::Titulo:
title Windows Terminal - Configurar

:: Inicia o programa 
PowerShell.exe -ExecutionPolicy Bypass -File "%~dp0\Scripts\facilitarConfig.ps1"
pause