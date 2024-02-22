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
                       score += 2 + cards[chosenIndex].bonus + cards[potentialMatchIndex].bonus
                   }
                   else {
                       if cards[chosenIndex].hasBeenSeen {
                           score -= 1
                       }
                       if cards[potentialMatchIndex].hasBeenSeen {
                           score -= 1
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
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
                
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var hasBeenSeen = false
        var isMatched = false {
            didSet {
                if isMatched {
                    stopUsingBonusTime()
                }
            }
        }
        var content: CardContent // a dont care, we do not care what type, a generic
        var id: String
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" :"down") \(isMatched ? "Matched" : "Not-Matched")"
        }
        
        // MARK: - Bonus Time
        
        // call this when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isFaceUp && !isMatched && bonusPercentRemaining > 0, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // call this when the card goes back face down or gets matched
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
        // the bonus earned so far (one point for every second of the bonusTimeLimit that was not used)
        // this gets smaller and smaller the longer the card remains face up without being matched
        var bonus: Int {
            Int(bonusTimeLimit * bonusPercentRemaining)
        }
        
        // percentage of the bonus time remaining
        var bonusPercentRemaining: Double {
            bonusTimeLimit > 0 ? max(0, bonusTimeLimit - faceUpTime)/bonusTimeLimit : 0
        }
        
        // how long this card has ever been face up and unmatched during its lifetime
        // basically, pastFaceUpTime + time since lastFaceUpDate
        var faceUpTime: TimeInterval {
            if let lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // can be zero which would mean "no bonus available" for matching this card quickly
        var bonusTimeLimit: TimeInterval = 6
        
        // the last time this card was turned face up
        var lastFaceUpDate: Date?
        
        // the accumulated time this card was face up in the past
        // (i.e. not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
    }
}



extension Array {
    var only: Element? {
        return count == 1 ? first: nil
    }
}
