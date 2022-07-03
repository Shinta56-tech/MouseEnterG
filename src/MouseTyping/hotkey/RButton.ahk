;*****************************************************************************************************************************************
; 関数

CheckRButtonSend() {
    Return (A_PriorHotkey=="**RButton")
        && (A_TimeSincePriorHotkey<MT_LONG_PRESS_DELAY)
        && (A_PriorKey="RButton")
}

;*****************************************************************************************************************************************
; ホットキー

#If CheckAWinMouseEnterG(rb)

    *RButton::
        MT_RBUTTON := True
    Return

#If !rb && MT_RBUTTON && CheckRButtonSend()

    *RButton Up::
        Send, {Blind}{RButton}
        MT_RBUTTON := False
    Return

#If !rb && MT_RBUTTON

    *RButton Up::
        ;Send, {Blind}{RButton}
        MT_RBUTTON := False
    Return