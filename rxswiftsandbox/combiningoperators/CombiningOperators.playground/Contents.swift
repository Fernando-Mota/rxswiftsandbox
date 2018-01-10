//: Playground - noun: a place where people can play

import UIKit
import RxSwift

example(of: "Startwith") {
    let disposeBag = DisposeBag()
    
    let numbers = Observable<Int>.of(2, 3, 4, 5)
    
    let newNumbers = numbers.startWith(1)
    
    
    newNumbers.subscribe(onNext: { value in
        print(value)
    }).disposed(by: disposeBag)
}

example(of: "concat estatico") {
    let disposeBag = DisposeBag()
    
    let observableOne = Observable.of(1, 2, 3, 4)
    
    let observableTwo = Observable.of(5, 6, 7, 8)
    
    let observable = Observable.concat([observableOne, observableTwo])
    
    observable.subscribe(onNext: { value in
        print(value)
    }).disposed(by: disposeBag)
}

example(of: "concat(_:)") {
    let disposeBag = DisposeBag()
    
    let germanCities = Observable.of("Berlin", "Munich", "Frankfurt")
    
    let spanishCities = Observable.of("Madrid", "Barcelona", "Valencia")
    
    let observable = germanCities.concat(spanishCities)
    
    observable.subscribe(onNext: { city in
        print(city)
    }).disposed(by: disposeBag)
}

example(of: "concatMap") {
    let disposeBag = DisposeBag()
    
    let sequences = [
        "Germany": Observable.of("Berlin", "Munich", "Frankfurt"),
        "Spain": Observable.of("Madrid", "Barcelona", "Valencia")
    ]
    
    let observable = Observable.of("Germany", "Spain").concatMap{ country in
        sequences[country] ?? .empty()
    }
    
    observable.subscribe(onNext: { string in
        print(string)
    }).disposed(by: disposeBag)
}

example(of: "merge") {
    
    let left = PublishSubject<String>()
    
    let right = PublishSubject<String>()
    
    let source = Observable.of(left.asObservable(), right.asObservable())
    
    let observable = source.merge()
    
    let disposable = observable.subscribe(onNext: { value in
        print(value)
    })
    
    var leftValues = ["Berlin", "Munich", "Frankfurt"]
    
    var rightValues = ["Madrid", "Barcelona", "Valencia"]

    repeat {
        if arc4random_uniform(2) == 0 {
            if !leftValues.isEmpty {
                left.onNext("Left: "+leftValues.removeFirst())
            }
        } else if !rightValues.isEmpty {
            right.onNext("Right: "+rightValues.removeFirst())
        }
    } while !leftValues.isEmpty || !rightValues.isEmpty
    
    disposable.dispose()
}



example(of: "combineLatest") {
    
    let left = PublishSubject<String>()
    
    let right = PublishSubject<String>()
    
    let observable = Observable.combineLatest(left, right, resultSelector: { lastLeft, lastRight in
        "\(lastLeft) \(lastRight)"
    })
    
    let disposable = observable.subscribe(onNext: { value in
        print(value)
    })
    
    print("> Sending a value to left")
    left.onNext("Hello,")
    print("> Sending a value to right")
    right.onNext("world")
    print("> Sending another value to right")
    right.onNext("RxSwift")
    print("> Sending another value to Left")
    left.onNext("Have a good day, ")
    disposable.dispose()
}

example(of: "combine user and value") {
    let choice : Observable<DateFormatter.Style> = Observable.of(.short, .long)
    
    let dates = Observable.of(Date())
    
    let observable = Observable.combineLatest(choice, dates) {format, when -> String in
        let formatter = DateFormatter()
        
        formatter.dateStyle = format
        
        return formatter.string(from: when)
    }
    
    observable.subscribe(onNext: { value in
        print(value)
    })
}

example(of: "zip") {
    
    enum Weather {
        case cloudy
        case sunny
    }
    
    let left: Observable<Weather> = Observable.of(.sunny, .cloudy, .cloudy, .sunny)
    
    let right = Observable.of("Lisbon", "Copenhagen", "London", "Madrid", "Vienna")
    
    let observable = Observable.zip(left, right) { weather, city in
        return "It's \(weather) in \(city)"
    }
    
    observable.subscribe(onNext: {value in
        print(value)
    })
}

example(of: "withLastestFrom") {
    
    let button = PublishSubject<Void>()
    
    let textField = PublishSubject<String>()
    
    let observable = button.withLatestFrom(textField)
    
    _ = observable.subscribe(onNext: { value in
        print(value)
    })
    
    textField.onNext("Par")
    textField.onNext("Pari")
    textField.onNext("Paris")
    
    button.onNext(())
    button.onNext(())
    
    
}








