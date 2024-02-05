//
//  MemorizeGame.swift
//  cs193pfirst
//
//  Created by Michael Bernaski on 2/1/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>  // access control 
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneFaceUpcard: Int?
    
    mutating func shuffle() {
        cards.shuffle()
         }
    
    func findCardIndex(_ card: Card)-> Int?  {
        
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return nil
    }
    
   mutating func choose(_ card: Card) {
        
       if let chosenIndex = findCardIndex(card) {
           if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
               if let potentialMatchIndex = indexOfTheOneFaceUpcard {
                   if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                       cards[chosenIndex].isMatched = true
                       cards[potentialMatchIndex].isMatched = true
                   }
                   indexOfTheOneFaceUpcard = nil
               } else {
                   for index in cards.indices {
                       cards[index].isFaceUp = false
                   }
                   indexOfTheOneFaceUpcard = chosenIndex
               }
               
               cards[chosenIndex].isFaceUp = true
           }
               
       }
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
//        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
//            return  lhs.isFaceUp == rhs.isFaceUp &&
//            lhs.content == rhs.content &&
//            lhs.isMatched == rhs.isMatched
//        }
        
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent // a dont care, we do not care what type, a generic 
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" :"down") \(isMatched ? "Matched" : "Not-Matched")"
        }
        
    }
}
