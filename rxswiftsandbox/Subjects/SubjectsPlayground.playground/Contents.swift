//: Playground - noun: a place where people can play

import UIKit
import RxSwift

public func example(of descrption: String, action:() -> Void) {
    print("\n --- Example of: ", descrption, "---")
    action()
}

example(of: "PublishSubject") {
    
    let subject = PublishSubject<String>()
    subject.onNext("Is anyone listening?")
    
    let subscriptionOne = subject.subscribe(onNext: { string in
        print(string)
    })
    
    subject.on(.next("1"))
    subject.onNext("2")
    
    let subscriptionTwo = subject.subscribe { event in
        print("2)", event.element ?? event)
    }
    
    subject.onNext("3")
    subscriptionOne.dispose()
    subject.onNext("4")
    
    subject.onCompleted()
    
    subject.onNext("5")
    
    subscriptionTwo.dispose()
    
    let disposeBag = DisposeBag()
    
    subject.subscribe{ event in
        print("3)", event.element ?? event)
    }.disposed(by: disposeBag)
    
    subject.onNext("?")
}

enum MyError: Error {
    
    case anError
    
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, event.element ?? event.error ?? event)
}

example(of: "BehaviorSubject") {
    
    let subject = BehaviorSubject(value: "Initial value")
    
    let disposeBag = DisposeBag()
    
    subject
        .subscribe{ event in
            print(label: "1)", event: event)
        }.disposed(by: disposeBag)
    
    subject.onNext("X")
    
    subject.onError(MyError.anError)
    
    subject.subscribe{ event in
        print(label: "2)", event: event)
    }
}

example(of: "ReplaySubject") {
    
    let subject = ReplaySubject<String>.create(bufferSize: 2)
    
    let disposeBag = DisposeBag()
    
    subject.onNext("1")
    
    subject.onNext("2")
    
    subject.onNext("3")
    
    subject
        .subscribe { event in
            print(label: "1)", event: event)
        }.disposed(by: disposeBag)
    
    subject
        .subscribe { event in
            print(label: "2)", event: event)
        }.disposed(by: disposeBag)
    
    subject.onNext("4")
    
    subject.onError(MyError.anError)
    subject.dispose()
    
    
    subject
        .subscribe{ event in
            print(label: "3)", event: event)
        }.disposed(by: disposeBag)
    
    
}

example(of: "variable") {
    
    var variable = Variable("Initial value")
    
    let disposeBag = DisposeBag()
    
    variable.value = "New initial value"
    
    variable.asObservable()
        .subscribe{ event in
            print(label: "1)", event: event)
        }.disposed(by: disposeBag)
    
    variable.value = "1"
    
    variable.asObservable()
        .subscribe{ event in
            print(label: "2)", event: event)
        }.disposed(by: disposeBag)
    
    variable.value = "2"
}



























