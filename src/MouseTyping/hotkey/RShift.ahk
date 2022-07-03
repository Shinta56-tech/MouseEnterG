;*****************************************************************************************************************************************
; 関数

CheckSendX2Layer() {
    Return !MT_X2LAYER && GetKeyState("LControl")
}

CheckSendLWin() {
    Return (A_Priorkey="RShift")
        && (A_PriorHotkey="*RShift Up")
        && (A_TimeSincePriorHotkey<MT_DUBL_CLICK_DELAY)
}

;*****************************************************************************************************************************************
; ホットキー

;----------------------------------------------------------------------------------------------------------------------------

#If CheckAWinMouseEnterG(rs) && !MT_RSHIFT && CheckSendX2Layer()

    *RShift::
        MT_RSHIFT := True
        MT_X2LAYER := True
        Send,{LControl Up}
        Send,{LAlt Down}{Tab}
    Return

#If !rs && MT_RSHIFT && MT_X2LAYER

    *RShift Up::
        MT_X2LAYER := False
        MT_RSHIFT := False
    Return

;----------------------------------------------------------------------------------------------------------------------------

#If CheckAWinMouseEnterG(rs) && !MT_RSHIFT && CheckSendLWin()

    *RShift::
        MT_RSHIFT := True
        Send,{LWin Down}
    Return

#If CheckAWinMouseEnterG(rs) && !MT_RSHIFT

    *RShift::
        MT_RSHIFT := True
        Send,{LShift Down}
    Return

#If !rs && MT_RSHIFT && GetKeyState("LShift")

    *RShift Up::
        Send,{LShift Up}
        MT_RSHIFT := False
    Return

#If !rs && MT_RSHIFT && GetKeyState("LWin")

    *RShift Up::
        Send,{LWin Up}
        MT_RSHIFT := False
    Return

#If !rs && MT_RSHIFT && GetKeyState("LAlt")

    *RShift Up::
        Send,{LAlt Up}
        MT_RSHIFT := False
    Return

#If !rs && MT_RSHIFT

    *RShift Up::
        MT_RSHIFT := False
    Return