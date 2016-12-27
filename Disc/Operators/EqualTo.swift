// https://github.com/paulyoung/OptionalEquatableCollection


internal func == <Element: Equatable>(lhs: Array<Element>?, rhs: Array<Element>?) -> Bool {
    switch (lhs, rhs) {
    case let (.some(lhs), .some(rhs)):
        return lhs == rhs
    case (.none, .none):
        return true
    default:
        return false
    }
}
