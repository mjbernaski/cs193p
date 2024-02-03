//
//  EmojiMemoryGame.swift
//  cs193pfirst
//
//  Created by Michael Bernaski on 2/1/24.
//

import SwiftUI  // needs to know about these things



class EmojiMemoryGame: ObservableObject {
    
    static let emojis = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🦄", "🐔", "🐧", "🐦", "🐺"] // namespace globals
    
    private static func createMemoryGame() -> MemoryGame<String> { // return types always have to be explicit
        return MemoryGame(numberOfPairsOfCards: 10) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex] }
            else {return "🤮"}
            
        }
    }

@Published private var model = createMemoryGame()

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
 //       print(cards)
    }
    
    func choose(_ card: MemoryGame<String>.Card) {  // this is an intent function 
        model.choose(card)
    }
    
    
}


