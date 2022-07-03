;*****************************************************************************************************************************************
; 関数

CheckSpaceSend() {
    ;ToolTip, % A_PriorHotkey . " " . A_TimeSinceThisHotkey . " " . A_PriorKey
    Return (A_TimeSinceThisHotkey<MT_LONG_PRESS_DELAY)
        && (A_PriorKey=="Space")
}

;*****************************************************************************************************************************************
; ホットキー

#If CheckAWinMouseEnterG(sp)

    *Space::
        If MT_SPACE {
            Return
        }
        MT_SPACE := True
        KeyWait, Space
        If CheckSpaceSend() {
            Send, {Blind}{Space}
        }
        MT_SPACE := False
    Return