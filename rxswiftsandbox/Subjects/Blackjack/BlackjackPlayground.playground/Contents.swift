//: Playground - noun: a place where people can play

import UIKit
import RxSwift

//Blackjack usando subjects

class Card {
    
    let id: Int
    
    let description: String
    
    let value: Int
    
    init (id: Int, description: String, value: Int) {
        self.id = id
        self.description = description
        self.value = value
    }
}


let deck = [
    Card(id: 0, description: "As Paus", value:1),
    Card(id: 0, description: "Dois Paus", value: 2),
    Card(id: 0, description: "Três Paus", value: 3),
    Card(id: 0, description: "Quatro Paus", value: 4),
    Card(id: 0, description: "Cinco Paus", value: 5),
    Card(id: 0, description: "Seis Paus", value: 6),
    Card(id: 0, description: "Sete Paus", value: 7),
    Card(id: 0, description: "Oito Paus", value: 8),
    Card(id: 0, description: "Nove Paus", value: 9),
    Card(id: 0, description: "Dez Paus", value: 10),
    Card(id: 0, description: "Dama Paus", value: 10),
    Card(id: 0, description: "Valete Paus", value: 10),
    Card(id: 0, description: "Rei Paus", value: 10),
    Card(id: 0, description: "As Ouros", value:1),
    Card(id: 0, description: "Dois Ouros", value: 2),
    Card(id: 0, description: "Três Ouros", value: 3),
    Card(id: 0, description: "Quatro Ouros", value: 4),
    Card(id: 0, description: "Cinco Ouros", value: 5),
    Card(id: 0, description: "Seis Ouros", value: 6),
    Card(id: 0, description: "Sete Ouros", value: 7),
    Card(id: 0, description: "Oito Ouros", value: 8),
    Card(id: 0, description: "Nove Ouros", value: 9),
    Card(id: 0, description: "Dez Ouros", value: 10),
    Card(id: 0, description: "Dama Ouros", value: 10),
    Card(id: 0, description: "Valete Ouros", value: 10),
    Card(id: 0, description: "Rei Ouros", value: 10),
    Card(id: 0, description: "As Copas", value:1),
    Card(id: 0, description: "Dois Copas", value: 2),
    Card(id: 0, description: "Três Copas", value: 3),
    Card(id: 0, description: "Quatro Copas", value: 4),
    Card(id: 0, description: "Cinco Copas", value: 5),
    Card(id: 0, description: "Seis Copas", value: 6),
    Card(id: 0, description: "Sete Copas", value: 7),
    Card(id: 0, description: "Oito Copas", value: 8),
    Card(id: 0, description: "Nove Copas", value: 9),
    Card(id: 0, description: "Dez Copas", value: 10),
    Card(id: 0, description: "Dama Copas", value: 10),
    Card(id: 0, description: "Valete Copas", value: 10),
    Card(id: 0, description: "Rei Copas", value: 10),
    Card(id: 0, description: "As Espadas", value:1),
    Card(id: 0, description: "Dois Espadas", value: 2),
    Card(id: 0, description: "Três Espadas", value: 3),
    Card(id: 0, description: "Quatro Espadas", value: 4),
    Card(id: 0, description: "Cinco Espadas", value: 5),
    Card(id: 0, description: "Seis Espadas", value: 6),
    Card(id: 0, description: "Sete Espadas", value: 7),
    Card(id: 0, description: "Oito Espadas", value: 8),
    Card(id: 0, description: "Nove Espadas", value: 9),
    Card(id: 0, description: "Dez Espadas", value: 10),
    Card(id: 0, description: "Dama Espadas", value: 10),
    Card(id: 0, description: "Valete Espadas", value: 10),
    Card(id: 0, description: "Rei Espadas", value: 10)]

var dealer = [Card]()
var player = Array<Card>()

func pickRandomCard() -> Card {
    return deck[Int(arc4random_uniform(51) + 1)]
}

func generateGame() -> Array<Array<Card>> {
    let firstHand = [pickRandomCard(), pickRandomCard(), pickRandomCard()]
    let secondHand = [pickRandomCard(), pickRandomCard(), pickRandomCard()]
    return [firstHand, secondHand]
}


func game() -> PublishSubject<Array<Array<Card>>> {
   let result = PublishSubject<Array<Array<Card>>>()
   return result
}

func gameResult() {
    print("\n ------------ Dealer cards: ------------")
    for card in dealer {
        print("\n \(card.description) value of \(card.value)")
    }
    print("\n Dealer points \(calcPoints(cards: dealer))")
    
    print("\n ------------ Player cards: ------------")
    for card in player {
        print("\n \(card.description) value of \(card.value)")
    }
    print("\n Player points \(calcPoints(cards: player))")
    print("\n ------------ Game Result: \(calcGameResult()) ------------")
}

func calcPoints(cards: Array<Card>) -> Int {
    var points: Int = 0
    for card in cards {
        points += card.value
    }
    return points
}

func calcGameResult() -> String {
    let dealerPoints = calcPoints(cards: dealer)
    let playerPoints = calcPoints(cards: player)
    
    if playerPoints > 21 {
        return "SE FUDEU"
    } else if playerPoints < dealerPoints {
        return "SE FUDEU"
    } else if playerPoints == dealerPoints {
        return "SE FUDEU"
    }
    return "GANHOU"
}

let disposeBag = DisposeBag()
let gameOne = game()



gameOne.subscribe(onNext: { cards in
    dealer = cards[0]
    player = cards[1]
}, onError: { error in
    print(error)
}, onCompleted: {
    gameResult()
}) {
    print("Acabou!")
}.disposed(by: disposeBag)

gameOne.onNext(generateGame())
gameOne.onCompleted()

