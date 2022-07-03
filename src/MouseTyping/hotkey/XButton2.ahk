;*****************************************************************************************************************************************
; ホットキー

;----------------------------------------------------------------------------------------------------------------------------

#If CheckAWinMouseEnterG(rs) && !MT_RSHIFT && CheckSendX2Layer()

    *XButton2::
        MT_RSHIFT := True
        MT_X2LAYER := True
        Send,{LControl Up}
        Send,{LAlt Down}{Tab}
    Return

#If !rs && MT_RSHIFT && MT_X2LAYER

    *XButton2 Up::
        MT_X2LAYER := False
        MT_RSHIFT := False
    Return

;----------------------------------------------------------------------------------------------------------------------------

#If CheckAWinMouseEnterG(rs) && !MT_RSHIFT && CheckSendLWin()

    *XButton2::
        MT_RSHIFT := True
        Send,{LWin Down}
    Return

#If CheckAWinMouseEnterG(rs) && !MT_RSHIFT

    *XButton2::
        MT_RSHIFT := True
        Send,{LShift Down}
    Return

#If !rs && MT_RSHIFT && GetKeyState("LShift")

    *XButton2 Up::
        Send,{LShift Up}
        MT_RSHIFT := False
    Return

#If !rs && MT_RSHIFT && GetKeyState("LWin")

    *XButton2 Up::
        Send,{LWin Up}
        MT_RSHIFT := False
    Return

#If !rs && MT_RSHIFT && GetKeyState("LAlt")

    *XButton2 Up::
        Send,{LAlt Up}
        MT_RSHIFT := False
    Return

#If !rs && MT_RSHIFT

    *XButton2 Up::
        MT_RSHIFT := False
    Return