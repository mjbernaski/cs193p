//
//  MemorizeGame.swift
//  cs193pfirst
//
//  Created by Michael Bernaski on 2/1/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>  // access control 
    private(set) var score = 0
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(isFaceUp: false, isMatched: false, content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    var indexOfTheOneFaceUpcard: Int? { // a computed property
        get {
            cards.indices.filter {index in cards[index].isFaceUp}.only
            
//            
//            let faceUpCardIndices = cards.indices.filter {index in cards[index].isFaceUp}
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
//            
            
//            var faceUpCardIndices = [Int]()
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    faceUpCardIndices.append(index)
//                }
//            }
//            if faceUpCardIndices.count == 1 {
//                return faceUpCardIndices.first
//            }
//            else {
//                return nil
//            }
        }
        
        
        set {
            // newValue
            
            return cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}
            
//            for index in cards.indices {
//                if index == newValue {
//                    cards[index].isFaceUp = true
//                } else {
//                    cards[index].isFaceUp = false
//                }
//            }
        }
    }
    
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
    
    // TO DO - subtracting from score not working 
    
   mutating func choose(_ card: Card) {
        
       if let chosenIndex = findCardIndex(card) {
           if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
               if let potentialMatchIndex = indexOfTheOneFaceUpcard {
                   if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                       cards[chosenIndex].isMatched = true
                       cards[potentialMatchIndex].isMatched = true
                       score += 2
                   }
                   else {
                       if cards[chosenIndex].hasBeenSeen {
                           score -= 1
                           print("has been seen")
                       }
                       if cards[potentialMatchIndex].hasBeenSeen {
                           score -= 1
                           print("has been seen")
                       }
                   }
               } else {
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
        
        var isFaceUp = false {
            didSet {
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var hasBeenSeen = false
        var isMatched: Bool
        var content: CardContent // a dont care, we do not care what type, a generic 
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" :"down") \(isMatched ? "Matched" : "Not-Matched")"
        }
        
    }
}


extension Array {
    var only: Element? {
        return count == 1 ? first: nil
    }
}
