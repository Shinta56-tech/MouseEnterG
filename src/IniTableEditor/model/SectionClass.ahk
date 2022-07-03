class SectionClass {
    
    __New(pInipath, pSection) {
        this._inipath := pInipath
        this._section := pSection
    }

    __Get(pName) {
        if (pName="inipath") {
            return this._inipath
        } else if (pName="name") {
            return this._section
        } else if (pName="cols") {
            IniRead, vCols, % this._inipath, % this._section, |Cols|
            return StrSplit(vCols, INITABLEEDITOR_SPLITTEXT)
        }  else if (pName="keys") {
            IniRead, vKeys, % this._inipath, % this._section
            vKeys := "DummyKey=Dummy`n" . vKeys
            Loop, Parse, vKeys, `n,
            {
                vKeyStr .= RegExReplace(A_LoopField, "(?<=(=)).+")
            }
            vKeyStr := RegExReplace(vKeyStr, "=$")
            vKeys := StrSplit(vKeyStr, "=")
            vKeys.RemoveAt(1)
            Return vKeys
        }
    }

    __Set(pName, pValues) {
        if IsObject(pValues) {
        } else {
            if (pName="name") {
                vName := pValues
                IniRead, vCheck1, % this._inipath , % vName
                if (vCheck1="") {
                    FileRead, vIniFileText, % this._inipath
                    vIniFileText := RegExReplace(vIniFileText, "(?<=\[)" . this._section . "(?=\])", vName)
                    FileDelete, % this._inipath
                    FileAppend, % vIniFileText, % this._inipath
                } else {
                    vMsg := ""
                    vMsg .= "`n" . A_ThisFunc . " section"
                    vMsg .= "`n" . "Section is already registered"
                    vMsg .= "`n" . "Section: " . vSection
                    vMsg .= "`n"
                    Throw, % vMsg
                }
            }
        }
        
    }

    getRecord(pKey) {
        vKeys := this.keys
        vKeys.RemoveAt(1)
        if pKey is number
        {
            For i, f in vKeys
            {
                if (pKey=i) {
                    return New RecordClass(this.inipath, this._section, f)
                }
            }
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "Key does not exist"
            vMsg .= "`n" . "Section: " . this._section
            vMsg .= "`n" . "KeyNum: " . pKey
            vMsg .= "`n"
            Throw, % vMsg
        }
        else
        {
            For i, f in vKeys
            {
                if (pKey=f) {
                    return New RecordClass(this.inipath, this._section, f)
                }
            }
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "Key does not exist"
            vMsg .= "`n" . "Section: " . this._section
            vMsg .= "`n" . "Key: " . pKey
            vMsg .= "`n"
            Throw, % vMsg
        }
    }

    addRecord(pKey) {
        IniRead, vCheck1, % this._inipath , % this._section, % pKey
        if (vCheck1="ERROR") {
            vCols := this.cols
            vCols.RemoveAt(1)
            For i, f in vCols
            {
                vSetValue .= f . INITABLEEDITOR_SPLITTEXT
            }
            vSetValue := RegExReplace(vSetValue, INITABLEEDITOR_SPLITTEXT_REGEXP . "$")
            IniWrite, % vSetValue, % this._inipath, % this._section, % pKey
            return New RecordClass(this.inipath, this._section, pKey)
        } else {
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "already registered"
            vMsg .= "`n" . "Section: " . this._section
            vMsg .= "`n" . "Key: " . pKey
            vMsg .= "`n"
            Throw, % vMsg
        }
    }

    deleteRecord(pKey) {
        vKeys := this.keys
        vKeys.RemoveAt(1)
        if pKey is number
        {
            For i, f in vKeys
            {
                if (pKey=i) {
                    IniDelete, % this._inipath, % this._section, % f
                    Return 1
                }
            }
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "Key does not exist"
            vMsg .= "`n" . "Section: " . this._section
            vMsg .= "`n" . "KeyNum: " . pKey
            vMsg .= "`n"
            Throw, % vMsg
        }
        else
        {
            For i, f in vKeys
            {
                if (pKey=f) {
                    IniDelete, % this._inipath, % this._section, % f
                    Return 1
                }
            }
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "Key does not exist"
            vMsg .= "`n" . "Section: " . this._section
            vMsg .= "`n" . "Key: " . pKey
            vMsg .= "`n"
            Throw, % vMsg

        }
    }
}