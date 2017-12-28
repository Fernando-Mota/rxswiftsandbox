//: Playground - noun: a place where people can play

import UIKit
import RxSwift

//User session tracking

class User {
    let login: String
    
    let pass: String
    
    init(login: String, pass: String) {
        self.login = login
        self.pass = pass
    }
}

let db = [
    User(login: "fernando", pass: "123"),
    User(login: "mota", pass: "123"),
    User(login: "coiso", pass: "123"),
]

var session = Variable<Bool>(false)

func login(login: String, pass: String) -> Bool {
    for user in db {
        if user.login.contains(login) {
            if user.pass.contains(pass) {
                return true
            }
        }
    }
    return false
}

func performActionReequiringLoggedIn(logged: Bool) {
    if logged {
        print("Você pode executar a ação")
    } else {
        print("Você NAO pode executar a ação")
    }
}

session.asObservable()
    .subscribe (onNext: { logado in
        performActionReequiringLoggedIn(logged: logado)
    })

session.value = login(login: "fernando", pass: "123")









