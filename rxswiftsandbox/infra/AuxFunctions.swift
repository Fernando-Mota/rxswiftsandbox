//
//  AuxFunctions.swift
//  rxswiftsandbox
//
//  Created by Fernando Mota e Silva on 26/12/17.
//  Copyright © 2017 Fernando Mota e Silva. All rights reserved.
//

import Foundation

public func example(of descrption: String, action:() -> Void) {
    print("\n Example of: ", descrption, "----")
    action()
}
