;*****************************************************************************************************************************************
; 初期設定

; 設定ファイル
    vINI := "ini\MouseTyping.ini"

; 設定値の読み込み
    IniRead, MT_LONG_PRESS_DELAY, %vINI%, PROPERTY, LONG_PRESS_DELAY
    IniRead, MT_DUBL_CLICK_DELAY, %vINI%, PROPERTY, DUBL_CLICK_DELAY
    