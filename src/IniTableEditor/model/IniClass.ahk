class IniClass {
    
    __New(pInipath) {
        this._inipath := pInipath
    }

    __Get(pName) {
        if (pName="inipath") {
            return this._inipath
        }  else if (pName="sections") {
            IniRead, vSections, % this._inipath
            vSections := "DummySection`n" . vSections
            Loop, Parse, vSections, `n,
            {
                vSectionsStr .= A_LoopField . INITABLEEDITOR_SPLITTEXT
            }
            vSectionsStr := RegExReplace(vSectionsStr, INITABLEEDITOR_SPLITTEXT_REGEXP . "$")
            vSections := StrSplit(vSectionsStr, INITABLEEDITOR_SPLITTEXT)
            vSections.RemoveAt(1)
            Return vSections
        }
    }

    getSection(pSection) {
        vSections := this.sections
        if pSection is number
        {
            For i, f in vSections
            {
                if (pSection=i) {
                    return New SectionClass(this.inipath, f)
                }
            }
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "Section does not exist"
            vMsg .= "`n" . "SectionNum: " . pSection
            vMsg .= "`n"
            Throw, % vMsg
        }
        else
        {
            For i, f in vSections
            {
                if (pSection=f) {
                    return New SectionClass(this.inipath, f)
                }
            }
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "Section does not exist"
            vMsg .= "`n" . "Section: " . pSection
            vMsg .= "`n"
            Throw, % vMsg
        }
    }

    addSection(pSection, pCols*) {
        IniRead, vCheck1, % this._inipath , % pSection
        if (vCheck1="") {
            For i, f in pCols
            {
                vColsStr .= f . INITABLEEDITOR_SPLITTEXT
            }
            vColsStr := RegExReplace(vColsStr, INITABLEEDITOR_SPLITTEXT_REGEXP . "$")
            IniWrite, % vColsStr, % this._inipath, % pSection, |Cols|
            Return New SectionClass(this._inipath, pSection)
        } else {
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "already registered"
            vMsg .= "`n" . "Section: " . pSection
            vMsg .= "`n"
            Throw, % vMsg
        }
    }

    deleteSection(pSection) {
        vSections := this.sections
        if pSection is number
        {
            For i, f in vSections
            {
                if (pSection=i) {
                    IniDelete, % this._inipath, % f
                    Return 1
                }
            }
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "Section does not exist"
            vMsg .= "`n" . "SectionNum: " . pSection
            vMsg .= "`n"
            Throw, % vMsg
        }
        else
        {
            For i, f in vSections
            {
                if (pSection=f) {
                    IniDelete, % this._inipath, % f
                    Return 1
                }
            }
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "Key does not exist"
            vMsg .= "`n" . "Section: " . pSection
            vMsg .= "`n"
            Throw, % vMsg
        }
    }

    moveSection(pSection, pPos) {
        vSections := this.sections
        if pSection is number
        {
            For i, f in vSections
            {
                if (pSection=i) {
                    this._moveSection(f, pPos)
                    Return 1
                }
            }
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "Section does not exist"
            vMsg .= "`n" . "SectionNum: " . pSection
            vMsg .= "`n"
            Throw, % vMsg
        }
        else
        {
            For i, f in vSections
            {
                if (pSection=f) {
                    this._moveSection(f, pPos)
                    Return 1
                }
            }
            vMsg := ""
            vMsg .= "`n" . A_ThisFunc
            vMsg .= "`n" . "Key does not exist"
            vMsg .= "`n" . "Section: " . pSection
            vMsg .= "`n"
            Throw, % vMsg
        }
    }

    _moveSection(pSection, pPos) {
        vSections := this.sections
        IniWrite, DummyVal, % this._inipath, Dummy, Dummykey
        FileRead, vIniStr, % this._inipath
        vDatasStr := RegExReplace(vIniStr, "\[.+?\]" , "[]")
        vDatas := StrSplit(vDatasStr, "[]")
        vDatas.RemoveAt(1)
        vDatas.RemoveAt(vDatas.MaxIndex())
        IniDelete % this._inipath, Dummy
        For i, f In vSections
        {
            if (pSection=f) {
                vTempNum := i
                vTempSection := f
                vTempData := vDatas[i]
                Break
            }
        }
        vSections[vTempNum] := vSections[vTempNum + pPos]
        vDatas[vTempNum] := vDatas[vTempNum + pPos]
        vSections[vTempNum + pPos] := vTempSection
        vDatas[vTempNum + pPos] := vTempData
        vIniStr := ""
        For i, f In vSections
        {
            vIniStr .= "[" . vSections[i] . "]" . vDatas[i] 
            IniDelete % this._inipath, % vSections[i]
        }
        FileAppend, % vIniStr, % this._inipath
    }

}