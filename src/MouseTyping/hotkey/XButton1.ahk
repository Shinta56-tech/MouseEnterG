;*****************************************************************************************************************************************
; ホットキー

;----------------------------------------------------------------------------------------------------------------------------

#If CheckAWinMouseEnterG(rc) && !MT_RCONTROL && CheckSendX1Layer()

    *XButton1::
        MT_RCONTROL := True
        MT_X1LAYER := True
        Send, {LShift Up}
    Return

#If !rc && MT_RCONTROL && MT_X1LAYER

    *XButton1 Up::
        MT_X1LAYER := False
        MT_RCONTROL := False
    Return

;----------------------------------------------------------------------------------------------------------------------------

#If CheckAWinMouseEnterG(rc) && !MT_RCONTROL && CheckSendLAlt()

    *XButton1::
        MT_RCONTROL := True
        Send,{LAlt Down}
    Return

#If CheckAWinMouseEnterG(rc) && !MT_RCONTROL

    *XButton1::
        MT_RCONTROL := True
        Send,{LControl Down}
    Return

#If !rc && MT_RCONTROL && GetKeyState("LControl")

    *XButton1 Up::
        Send,{LControl Up}
        MT_RCONTROL := False
    Return

#If !rc && MT_RCONTROL && GetKeyState("LAlt")

    *XButton1 Up::
        Send,{LAlt Up}
        MT_RCONTROL := False
    Return

#If !rc && MT_RCONTROL

    *XButton1 Up::
        MT_RCONTROL := False
    Return