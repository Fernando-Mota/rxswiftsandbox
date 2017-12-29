//: Playground - noun: a place where people can play

import UIKit
import RxSwift

example(of: "ignoreElements") {
    
    //Publish subjects emite os itens para quem já está inscrito
    let strikes = PublishSubject<String>()
    
    let disposeBag = DisposeBag()
    
    strikes
        .ignoreElements()
        .subscribe{ event in
            print("You are out")
        }.disposed(by: disposeBag)
    
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onNext("X")
    
    strikes.onCompleted()
}


example(of: "elementAt") {
    
    let strikes = PublishSubject<String>()
    
    let disposeBag = DisposeBag()
    
    strikes
        .elementAt(1)
        .subscribe(onNext: { _ in
            print("You are out!")
        }).disposed(by: disposeBag)
    
    strikes.onNext("X")
    strikes.onNext("X")
    strikes.onNext("X")
}

example(of: "filter") {
    
    let disposeBag = DisposeBag()
    
    Observable.of(1, 2, 3, 4, 5 , 6)
        .filter{ value in
            return value % 2 == 0
        }
        .subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
}

example(of: "skip") {
    let disposeBag = DisposeBag()
    
    Observable.of(1, 2, 3, 4, 5, 6)
        .skip(3)
        .subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
}

example(of: "skipWhile") {
    
    let disposeBag = DisposeBag()
    
    Observable.of(2, 2, 3, 4, 5, 6)
        .skipWhile{ value in
            return value % 2 == 0
        }.subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
}


example(of: "skipUntil") {
    
    let disposeBag = DisposeBag()
    
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    
    subject
        .skipUntil(trigger)
        .subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
    
    subject.onNext("Event 1")
    subject.onNext("Event 2")
    trigger.onNext("NOW!")
    subject.onNext("Event 3")
    subject.onNext("Event 4")
}














