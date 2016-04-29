func + <T, U>( lhs: [T: U], rhs: [T: U]) -> [T: U] {
    var nlhs = lhs
    for (key, val) in rhs {
        nlhs[key] = val
    }
    
    return nlhs
}
