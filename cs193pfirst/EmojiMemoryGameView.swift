//
//  EmojiMemoryGameView.swift
//  MyFirst193PApp
//
//  Created by Michael Bernaski on 1/30/24.
//

import SwiftUI

struct EmojiMemoryGameView: View  {
    typealias Card = MemoryGame<String>.Card
    
@ObservedObject var viewModel: EmojiMemoryGame
    
//    let emojis:[String] = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🦄", "🐔", "🐧", "🐦", "🐺"]
//    let emojisDescription:[String] = ["Dog", "Cat", "Mouse", "Hamster", "Rabbit", "Fox", "Bear", "Panda", "Koala", "Tiger", "Lion", "Cow", "Pig", "Frog", "Monkey", "Unicorn", "Chicken", "Penguin", "Bird", "Wolf"]
    
    var body: some View {
        VStack {
                cards
                    .animation(.default, value: viewModel.cards)
            HStack {
                score
                Spacer()
               shuffle
            }.padding()
        }
       
    }
    
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil) 
    }
    
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
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
                        .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 3)) {
                                viewModel.choose(card)  // Intents
                            }
                        }
                    }
                }

            }
    
    private func scoreChange(causedBy card: Card) -> Int {
        return 0
    }
        }
    



#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
