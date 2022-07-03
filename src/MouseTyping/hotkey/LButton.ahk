#If CheckAWinMouseEnterG(lb) && MT_RBUTTON

    *LButton::
        MT_LBUTTON := True
    Return

#If !lb && MT_LBUTTON

    *LButton Up::
        MT_LBUTTON := False
    Return