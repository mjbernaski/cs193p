//
//  EmojiMemoryGameView.swift
//  MyFirst193PApp
//
//  Created by Michael Bernaski on 1/30/24.
//

import SwiftUI

struct EmojiMemoryGameView: View  {
    
@ObservedObject var viewModel: EmojiMemoryGame
    
//    let emojis:[String] = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🦄", "🐔", "🐧", "🐦", "🐺"]
//    let emojisDescription:[String] = ["Dog", "Cat", "Mouse", "Hamster", "Rabbit", "Fox", "Bear", "Panda", "Koala", "Tiger", "Lion", "Cow", "Pig", "Frog", "Monkey", "Unicorn", "Chicken", "Penguin", "Bird", "Wolf"]
    
    var body: some View {
        VStack {
                cards
                    .animation(.default, value: viewModel.cards)
            Spacer()
            Button("Shuffle") {
                viewModel.shuffle()
            }
        } 
       
    }
    
    private let aspectRatio:CGFloat = 2/3
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) {card in
            if card.id.last == "b" || card.id.last == "a" {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)  // Intents
                        }
            }
        }

            }
        }
    



#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
