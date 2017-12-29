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

example(of: "take") {
    let disposeBag = DisposeBag()
    
    Observable.of(1, 2, 3, 4, 5, 6)
        .take(3)
        .subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
}

example(of: "takeWhile") {
    let disposeBag = DisposeBag()
    
    Observable.of(2, 2, 4, 4, 5, 6, 6)
        .enumerated()
        .takeWhile{ index, value in
            value % 2 == 0 && index < 3
        }.map { $0.element }
        .subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
}

example(of: "takeUntil") {
    let disposeBag = DisposeBag()
    
    let subject = PublishSubject<String>()
    let trigger = PublishSubject<String>()
    
    subject
        .takeUntil(trigger)
        .subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
    
    subject.onNext("elemento 1")
    subject.onNext("elemento 2")
    subject.onNext("elemento 3")
    trigger.onNext("X")
    subject.onNext("elemento 4")
    subject.onNext("elemento 5")
}

example(of: "distinctUntilChanged") {
    let disposeBag = DisposeBag()
    
    Observable.of("A", "A", "B", "B", "A")
        .distinctUntilChanged()
        .subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
}

example(of: "distinctUntilChanged(_:)") {
    let disposeBag = DisposeBag()
    
    let formatter = NumberFormatter()
    
    formatter.numberStyle = .spellOut
    
    Observable<NSNumber>.of(10, 110, 20, 200, 210, 310)
        .distinctUntilChanged{ a, b in
            guard let aWords = formatter.string(from: a)?.components(separatedBy: " "), let bWords = formatter.string(from: b)?.components(separatedBy: " ") else {return false}
            
            var containsMatch = false
            
            for aWord in aWords {
                for bWord in bWords {
                    if aWord == bWord {
                        containsMatch = true
                        break
                    }
                }
            }
            return containsMatch
        }
        .subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
}










