//
//  MemorizeGame.swift
//  cs193pfirst
//
//  Created by Michael Bernaski on 2/1/24.
//

import Foundation

struct MemoryGame<CardContent> {
    
    private(set) var cards: Array<Card>  // access control 
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(isFaceUp: true, isMatched: false, content: content))
            cards.append(Card(isFaceUp: false, isMatched: false, content: content))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    func choose(_ card: Card) {
        
        
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent // a dont care, we do not care what type, a generic 
    }
}
