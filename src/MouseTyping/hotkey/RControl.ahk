;*****************************************************************************************************************************************
; 関数

CheckSendX1Layer() {
    Return !MT_X1LAYER && GetKeyState("LShift")
}

CheckSendLAlt() {
    Return (A_Priorkey="RControl")
        && (A_PriorHotkey="*RControl Up")
        && (A_TimeSincePriorHotkey<MT_DUBL_CLICK_DELAY)
}

;*****************************************************************************************************************************************
; ホットキー

;----------------------------------------------------------------------------------------------------------------------------

#If CheckAWinMouseEnterG(rc) && !MT_RCONTROL && CheckSendX1Layer()

    *RControl::
        MT_RCONTROL := True
        MT_X1LAYER := True
        Send, {LShift Up}
    Return

#If !rc && MT_RCONTROL && MT_X1LAYER

    *RControl Up::
        MT_X1LAYER := False
        MT_RCONTROL := False
    Return

;----------------------------------------------------------------------------------------------------------------------------

#If CheckAWinMouseEnterG(rc) && !MT_RCONTROL && CheckSendLAlt()

    *RControl::
        MT_RCONTROL := True
        Send,{LAlt Down}
    Return

#If CheckAWinMouseEnterG(rc) && !MT_RCONTROL

    *RControl::
        MT_RCONTROL := True
        Send,{LControl Down}
    Return

#If !rc && MT_RCONTROL && GetKeyState("LControl")

    *RControl Up::
        Send,{LControl Up}
        MT_RCONTROL := False
    Return

#If !rc && MT_RCONTROL && GetKeyState("LAlt")

    *RControl Up::
        Send,{LAlt Up}
        MT_RCONTROL := False
    Return

#If !rc && MT_RCONTROL

    *RControl Up::
        MT_RCONTROL := False
    Return