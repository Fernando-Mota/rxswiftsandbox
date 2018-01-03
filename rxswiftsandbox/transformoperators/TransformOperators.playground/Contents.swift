//: Playground - noun: a place where people can play

import UIKit
import RxSwift

example(of: "toArray") {
    let disposeBag = DisposeBag()
    
    Observable.of("A", "B", "C", "D")
        .toArray()
        .subscribe(onNext: { values in
            print(values)
        }).disposed(by: disposeBag)
}


example(of: "map") {
    
    let disposeBag = DisposeBag()
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .spellOut
    
    Observable<NSNumber>.of(123, 4, 56)
        .map { number in
            formatter.string(from: number)
        }
        .subscribe(onNext: { value in
            print(value ?? "")
        }).disposed(by: disposeBag)
}


example(of: "enumerated and map") {
    let disposeBag = DisposeBag()
    
    Observable.of(1, 2, 3, 4, 5, 6, 7)
    .enumerated()
        .map {index, integer in
            index > 2 ? integer * 2 : integer
        }.subscribe(onNext: { value in
            print(value)
        }).disposed(by: disposeBag)
}

struct Student {
    var score: BehaviorSubject<Int>
}

example(of: "flatMap") {
    
    let disposeBag = DisposeBag()
    
    let ryan = Student(score: BehaviorSubject(value: 80))
    let charlotte = Student(score: BehaviorSubject(value: 90))
    
    let student = PublishSubject<Student>()
    
    student
        .flatMap { student in
            student.score
        }
        .subscribe(onNext: { score in
            print(score)
        }).disposed(by: disposeBag)
    
    student.onNext(ryan)
    
    ryan.score.onNext(85)
    student.onNext(charlotte)
    ryan.score.onNext(95)
    charlotte.score.onNext(100)
}

example(of: "flatMapLatest") {
    
    let disposeBag = DisposeBag()
    
    let ryan = Student(score: BehaviorSubject(value: 80))
    let charlotte = Student(score: BehaviorSubject(value: 90))
    
    let student = PublishSubject<Student>()
    
    student
        .flatMapLatest { student in
            student.score
        }
        .subscribe(onNext: { score in
            print(score)
        }).disposed(by: disposeBag)
    
    student.onNext(ryan)
    
    ryan.score.onNext(85)
    student.onNext(charlotte)
    ryan.score.onNext(95)
    charlotte.score.onNext(100)
}

example(of: "materialize and dematerializa") {
    
    enum MyError: Error {
        case anError
    }
    
    let disposeBag = DisposeBag()
    
    let ryan = Student(score: BehaviorSubject(value: 80))
    let charlotte = Student(score: BehaviorSubject(value: 100))
    
    let student = BehaviorSubject<Student>(value: ryan)
    
    let studentScore = student.flatMapLatest{ student in student.score.materialize()}
    
    studentScore
        .filter { event in
            guard event.error == nil else {
                print(event.error ?? "")
                return false
            }
            return true
        }
        .dematerialize()
        .subscribe(onNext: { score in
            print(score)
        }).disposed(by: disposeBag)
    
    ryan.score.onNext(85)
    
    ryan.score.onError(MyError.anError)
    
    ryan.score.onNext(90)
    
    student.onNext(charlotte)
}






















