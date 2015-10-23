// https://github.com/thoughtbot/Curry

internal func curry<A, B, C>(function: (A, B) -> C)(_ `a`: A)(_ `b`: B) -> C {
    return function(`a`, `b`)
}

internal func curry<A, B, C, D, E, F, G>(function: (A, B, C, D, E, F) -> G)(_ `a`: A)(_ `b`: B)(_ `c`: C)(_ `d`: D)(_ `e`: E)(_ `f`: F) -> G {
    return function(`a`, `b`, `c`, `d`, `e`, `f`)
}

internal func curry<A, B, C, D, E, F, G, H, I, J>(function: (A, B, C, D, E, F, G, H, I) -> J)(_ `a`: A)(_ `b`: B)(_ `c`: C)(_ `d`: D)(_ `e`: E)(_ `f`: F)(_ `g`: G)(_ `h`: H)(_ `i`: I) -> J {
    return function(`a`, `b`, `c`, `d`, `e`, `f`, `g`, `h`, `i`)
}
