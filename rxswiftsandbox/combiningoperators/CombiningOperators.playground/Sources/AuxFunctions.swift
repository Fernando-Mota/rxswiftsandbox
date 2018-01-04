import Foundation

public func example(of descrption: String, action:() -> Void) {
    print("\n Example of: ", descrption, "----")
    action()
}
