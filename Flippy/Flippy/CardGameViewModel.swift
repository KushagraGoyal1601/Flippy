//
//  CardGameViewModel.swift
//  Flippy
//
//  Created by Kushagra Goyal on 11/03/25.
//

import Foundation

struct Card {
    var value: String
    var isFLipped: Bool
    var isMatched: Bool
}

class CardGameViewModel {
    
    let cardValues = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    var numberOfCardsInGame: Int = 6 // To be taken from user based on difficulty level
    
    var randomValues: [String] {
        return Array(cardValues.shuffled().prefix(numberOfCardsInGame))
    }
    
    var cardArray: [Card] = []
    var flippedCardIndex: Int?
    
    init () {
        for value in randomValues {
            cardArray.append(Card(value: value, isFLipped: false, isMatched: false))
            cardArray.append(Card(value: value, isFLipped: false, isMatched: false))
        }
        cardArray.shuffle()
    }
    
    func cardDidTapped(at index: Int) {
        if cardArray[index].isMatched { return }
        if flippedCardIndex != nil && flippedCardIndex == index {
            return
        }
        cardArray[index].isFLipped.toggle()
    }
    
    func checkIfMatchFound(at index: Int) {
        guard !cardArray[index].isMatched else { return }
        if flippedCardIndex == nil {
            flippedCardIndex = index
        } else {
            if flippedCardIndex == index {
                return
            }
            let flippedCard = cardArray[flippedCardIndex!]
            if flippedCard.value == cardArray[index].value {
                cardArray[flippedCardIndex!].isFLipped = true
                cardArray[flippedCardIndex!].isMatched = true
                cardArray[index].isFLipped = true
                cardArray[index].isMatched = true
            } else {
                cardArray[flippedCardIndex!].isFLipped = false
                cardArray[index].isFLipped = false
            }
            flippedCardIndex = nil
        }
    }
}
