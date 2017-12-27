//: Playground - noun: a place where people can play

import UIKit

public func example(of descrption: String, action:() -> Void) {
    print("\n Example of: ", descrption, "----")
    action()
}


var texto: String?

texto = "Fernando"

extension Optional {
    
    func toString(defaultValue: String) -> String {
        if let result = self {
            if result is String {
                return result as! String
            }
            return defaultValue
        }
        return defaultValue
    }
    
}

print(texto.toString(defaultValue: ""))


