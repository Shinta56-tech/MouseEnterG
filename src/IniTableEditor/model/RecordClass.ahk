class RecordClass {
    
    __New(pInipath, pSection, pKey) {
        this._inipath := pInipath
        this._section := pSection
        this._key := pKey
    }

    __Get(pName) {
        if (pName="inipath") {
            return this._inipath
        } else if (pName="section") {
            return this._section
        } else if (pName="key") {
            return this._key
        } else if (pName="cols") {
            IniRead, vCols, % this._inipath, % this._section, |Cols|
            return StrSplit(vCols, INITABLEEDITOR_SPLITTEXT)
        } else if (pName="vals") {
            IniRead, vValue, % this._inipath , % this._section, % this._key
            return StrSplit(vValue, INITABLEEDITOR_SPLITTEXT)
        }
    }

    __Set(pName, pValues) {
        if IsObject(pValues) {
            if (pName="vals") {
                vCols := this.cols
                vCols.RemoveAt(1)
                For i, f in vCols
                {
                    vSetValue .= pValues[i] . INITABLEEDITOR_SPLITTEXT
                }
                vSetValue := RegExReplace(vSetValue, INITABLEEDITOR_SPLITTEXT_REGEXP . "$")
                IniWrite, % vSetValue, % this._inipath, % this._section, % this._key
            }
        } else {
            if (pName="section") {
                vSection := pValues
                IniRead, vCheck1, % this._inipath , % vSection
                IniRead, vCheck2, % this._inipath , % vSection, % this._key
                if (vCheck1!="") && (vCheck2="ERROR") {
                    IniRead, vValue, % this._inipath , % this._section, % this._key
                    IniWrite, % vValue, % this._inipath, % vSection, % this._key
                    IniDelete, % this._inipath, % this._section, % this._key
                } else {
                    if (vCheck1="") {
                        vMsg := ""
                        vMsg .= "`n" . A_ThisFunc . " section"
                        vMsg .= "`n" . "Section is not registered"
                        vMsg .= "`n" . "Section: " . vSection
                        vMsg .= "`n"
                        Throw, % vMsg
                    } else {
                        vMsg := ""
                        vMsg .= "`n" . A_ThisFunc . " section"
                        vMsg .= "`n" . "Already registered"
                        vMsg .= "`n" . "Section: " . vSection
                        vMsg .= "`n" . "Key: " . this._key
                        vMsg .= "`n"
                        Throw, % vMsg
                    }
                }
            } else if (pName="key") {
                vKey := pValues
                IniRead, vCheck, % this._inipath , % this._section, % vKey
                if (vCheck="ERROR") {
                    IniRead, vValue, % this._inipath , % this._section, % this._key
                    IniWrite, % vValue, % this._inipath , % this._section, % vKey
                    IniDelete, % this._inipath, % this._section, % this._key
                } else {
                    vMsg := ""
                    vMsg .= "`n" . A_ThisFunc . " key"
                    vMsg .= "`n" . "Already registered"
                    vMsg .= "`n" . "Section: " . this._section
                    vMsg .= "`n" . "Key: " . vKey
                    vMsg .= "`n"
                    Throw, % vMsg
                }
            }
        }
        
    }

    getField(pField) {
        vCols := this.cols
        vCols.RemoveAt(1)
        if pField is number
        {
            For i, f in vCols
            {
                if (pField=i) {
                    vVals := this.vals
                    return vVals[i]
                }
            }
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "Field does not exist"
            vMsg .= "`n" . "Section: " . this._section
            vMsg .= "`n" . "ColNum: " . pField
            vMsg .= "`n"
            Throw, % vMsg
        }
        else
        {
            For i, f in vCols
            {
                if (pField=f) {
                    vVals := this.vals
                    return vVals[i]
                }
            }
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "Field does not exist"
            vMsg .= "`n" . "Section: " . this._section
            vMsg .= "`n" . "Col: " . pField
            vMsg .= "`n"
            Throw, % vMsg

        }
    }

    setField(pField,pValue) {
        vCols := this.cols
        vCols.RemoveAt(1)
        vValues := this.vals
        if pField is number
        {
            For i, f in vCols
            {
                if (pField=i) {
                    vValues[i] := pValue
                    this.vals := vValues
                    return True
                }
            }
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "Field does not exist"
            vMsg .= "`n" . "Section: " . this._section
            vMsg .= "`n" . "ColNum: " . pField
            vMsg .= "`n"
            Throw, % vMsg
        }
        else
        {
            For i, f in vCols
            {
                if (pField=f) {
                    vValues[i] := pValue
                    this.vals := vValues
                    return True
                }
            }
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "Field does not exist"
            vMsg .= "`n" . "Section: " . this._section
            vMsg .= "`n" . "Col: " . pField
            vMsg .= "`n"
            Throw, % vMsg
        }
    }

}