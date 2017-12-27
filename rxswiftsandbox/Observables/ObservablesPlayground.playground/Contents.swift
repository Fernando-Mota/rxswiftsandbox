//: Playground - noun: a place where people can play

import UIKit
import RxSwift

public func example(of descrption: String, action:() -> Void) {
    print("\n--- Example of: ", descrption, "---")
    action()
}

example(of: "just, of, from") {
    let one = 1
    let two = 2
    let three = 3

    let observable: Observable<Int> = Observable.just(one)
    let observableTwo: Observable<Int> = Observable.of(one, two, three)
    let observableThree = Observable.of([one, two, three])
    let observableThreeTwo = Observable.of(one, two, three)
    let observableFour = Observable.from([one, two, three])
}

example(of: "subscribe") {
    let one = 1
    let two = 2
    let three = 3

    let observable = Observable.of(one, two, three)

    observable.subscribe { event in
        if let value = event.element {
            print(value)
        }
        print(event)
    }

    observable.subscribe(onNext: { value in
        print(value)
    })
}

example(of: "empty") {
    let observable = Observable<Void>.empty()

    observable.subscribe(
        onNext: { value in
            print(value)
        },
        onCompleted: {
            print("Completed!")
        })
}

example(of: "never") {
    
    
    let observable = Observable<Any>.never()

    observable
        .subscribe(
            onNext: { element in
                print(element)
        },

            onCompleted: {
                print("Completed never!")
        })
}

example(of: "range") {
    let observable = Observable<Int>.range(start: 1, count: 10)

    observable.subscribe(
        onNext: { value in
            let n = Double(value)
            let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) / 2.23606).rounded())
            print(fibonacci)
    },
        onCompleted: {
            print("Completed!")
    })
}

example(of: "dispose") {
    let observable = Observable.of("A", "B", "C")

    let subscription = observable.subscribe { event in
        print(event)
    }
    subscription.dispose()
}

example(of: "dispose bag") {
    let disposeBag = DisposeBag()

    Observable.of("A", "B", "C").subscribe{ event in
        if let value = event.element {
            print(value)
        }
    }.disposed(by: disposeBag)
}

enum MyError: Swift.Error {
    case anError
}

example(of: "create") {
    let disposeBag = DisposeBag()

    Observable<String>.create { observer in
        observer.onNext("A")

        observer.onError(MyError.anError)

        observer.onCompleted()

        observer.onNext("B")

        return Disposables.create()
        }.subscribe(onNext: { event in
            print(event)
        },
                    onError: { error in
                        print(error)
        },
                    onCompleted: {
                        print("completed")
        }).disposed(by: disposeBag)
}

example(of: "deferred") {
    let disposeBag = DisposeBag()
    
    var flip = false
    
    let factory: Observable<Int> = Observable.deferred{
        flip = !flip
        
        if flip {
            return Observable.of(1, 2, 3)
        } else {
            return Observable.of(4, 5, 6)
        }
    }
    
    for _ in 0...3 {
        factory.subscribe{ event in
            if let value = event.element {
                print(value, terminator: "")
            }
            
            }.disposed(by: disposeBag)
        print()
    }
}

example(of: "single") {
    let disposeBag = DisposeBag()
    
    enum FileReadError: Error {
        case fileNotFound, unreadable, encodingFailed
    }
    
    
    func loadText(from name: String) -> Single<String> {
        return Single.create { single in
            
            let disposable = Disposables.create()
            
            guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
                single(.error(FileReadError.fileNotFound))
                return disposable
            }
            
            
            
            guard let data = FileManager.default.contents(atPath: path) else {
                single(.error(FileReadError.unreadable))
                return disposable
            }

            guard let contents = String(data: data, encoding: .utf8) else {
                single(.error(FileReadError.encodingFailed))
                return disposable
            }
            
            single(.success(contents))
            return disposable
        }
    }
    
    loadText(from: "texto").subscribe{ event in
        
        switch event {
        case .success(let string):
            print(string)
        case .error(let error):
            print(error)
        }
    }.disposed(by: disposeBag)
}
























