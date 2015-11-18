func + <T, U>(var lhs: [T: U], rhs: [T: U]) -> [T: U] {
    for (key, val) in rhs {
        lhs[key] = val
    }
    
    return lhs
}
