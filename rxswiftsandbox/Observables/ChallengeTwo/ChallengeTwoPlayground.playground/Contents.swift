//: Playground - noun: a place where people can play

import UIKit
import RxSwift

public func example(of descrption: String, action:() -> Void) {
    print("\n --- Example of: ", descrption, "---")
    action()
}

example(of: "challenge one") {
    
    let disposeBag = DisposeBag()
    
    let observable = Observable<String>.never()
    
    observable.debug("fer").subscribe(
        onNext: { element in
            print(element)
        
    },
        onCompleted: {
            print("Completed never!")
    }).disposed(by: disposeBag)
}
