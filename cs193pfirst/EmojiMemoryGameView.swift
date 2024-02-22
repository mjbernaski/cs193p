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
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100: 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
            
        }
    }
        
        private func choose(_ card: Card) {
            withAnimation(.easeInOut(duration: 3)) {
                let scoreBeforeChoosing = viewModel.score
                viewModel.choose(card)  // Intents
                let scoreChange = viewModel.score - scoreBeforeChoosing
                lastScoreChange = (scoreChange, causedByCardId: card.id)
            }
        }
    
    @State private var lastScoreChange: (amount: Int, causedByCardId: Card.ID) = (0, causedByCardId: "")
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, causedByCardId: id) = lastScoreChange
        return card.id == id ? amount: 0
    }
        }
    



#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
