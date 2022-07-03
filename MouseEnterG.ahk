;*****************************************************************************************************************************************
; 基本設定

    #NoEnv
    #Persistent
    #SingleInstance, FORCE
    #UseHook
    #InstallKeybdHook
    #InstallMouseHook
    Process, Priority, , Realtime
    SetMouseDelay -1
    SetKeyDelay, -1
    SetBatchLines, -1
    CoordMode, Mouse, Screen

;*****************************************************************************************************************************************
; グローバル変数

    #Include, src\MouseTyping\Global.ahk

;*****************************************************************************************************************************************
; 初期化

    SetCapsLockState, AlwaysOff

    #Include, src\MouseTyping\Initialize.ahk

    Return

;*****************************************************************************************************************************************
; 基本ホットキー

    <!<^Escape::ExitApp
    <!Space::Reload
    <!LWin::Run, WindowSpy.exe

;*****************************************************************************************************************************************
; 基本関数

    ; ホットキー禁止画面判定関数
    CheckAWinMouseEnterG(p) {
        WinGet, ahkExe, ProcessName, A
        WinGetClass, ahkClass, A
        vINI := "ini\MouseEnterG.ini"
        IniRead, r, %vINI%, NOEXEWIN, %ahkExe%
        If (r!="ERROR") {
            Return False
        }
        IniRead, r, %vINI%, NOEXEWIN, %ahkClass%
        If (r!="ERROR") {
            Return False
        }
        Return True
    }

;*****************************************************************************************************************************************
; モジュール

    #Include, src\MouseTyping\Module.ahk