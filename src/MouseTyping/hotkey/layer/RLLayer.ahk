#If !rllayer && MT_RBUTTON && MT_LBUTTON

    *q::Return
    *w::vkBD ; \|
    *e::vkBB ; ;+
    *r::vkDC ; -=
    *t::Return
    *a::vkBA ; :*
    *s::vkDE ; ^~
    *d::vkDB ; [{
    *f::vkDD ; ]}
    *g::Return
    *z::vkBC ; ,<
    *x::vkBE ; .>
    *c::vkBF ; /?
    *v::vkC0 ; @`
    *b::vkE2 ; \_

    *Space::
        Send,{Escape}
    Return
    *CapsLock::Tab
    *vkF0::Tab