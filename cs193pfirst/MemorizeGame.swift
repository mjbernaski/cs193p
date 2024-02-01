//
//  MemorizeGame.swift
//  cs193pfirst
//
//  Created by Michael Bernaski on 2/1/24.
//

import Foundation

struct MemoryGame<CardContent> {
    
    var cards: Array<Card>
    
    func choose(card: Card) {
        
        
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent // a dont care, we do not care what type, a generic 
    }
}
