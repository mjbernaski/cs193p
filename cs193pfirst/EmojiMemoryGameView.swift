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
    
    var cards: some View {
        GeometryReader {geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: viewModel.cards.count,
                size: geometry.size,
                atAspectRatio: 2/3)
            
             LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)],spacing: 0) {
                ForEach(viewModel.cards) {card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .padding(4)
                        .onTapGesture {
                            viewModel.choose(card)  // Intents
                        }
                }

            }
        } .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
    }
    
    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat) -> CGFloat
    {
        print("size", size)
        let count = CGFloat(count)
        var columnCount = 1.0
        repeat {
            let width = size.width / columnCount
            print("columnCount ", columnCount)
            print("count ", count)
            print("width ", width)
            print("size ", size)
            let height = width / aspectRatio
            print("height ", height)
            print("size.height", size.height)
            let rowCount = (count / columnCount)
            print("rowCount ", rowCount)
            print("rowCount * height", rowCount * height)
            if (rowCount * height < size.height) {
                print((size.width / columnCount).rounded(.down))
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1.0
            print("--------------------")
        } while (columnCount < count)
        
        print(min(size.width / count, size.height * aspectRatio).rounded(.down))
        
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 1)
                    VStack {
                        Text(card.content).font(.system(size: 200)).minimumScaleFactor(0.01).aspectRatio(1, contentMode: .fit)
                     //   Text(card.id).font(.footnote)
                    }
                }.opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0: 1)
            
        }
        .foregroundColor(.teal)
        .opacity(card.isFaceUp || !card.isMatched ? 1:0)
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
