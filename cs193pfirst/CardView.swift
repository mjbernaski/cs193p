//
//  CardView.swift
//  cs193pfirst
//
//  Created by Michael Bernaski on 2/15/24.
//

import SwiftUI


struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: Card

    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 1)
                    Pie(endAngle: Angle.degrees(240))
                        .opacity(0.4)
                        .overlay(
                            Text(card.content)
                                .font(
                                    .system(size: 200))
                                .minimumScaleFactor(0.01)
                                .aspectRatio(1, contentMode:
                                .fit).padding(5)
                        )
                        .padding(5)
                }.opacity(card.isFaceUp ? 1 : 0)
            
            base.fill().opacity(card.isFaceUp ? 0: 1)
        }
        .foregroundColor(.teal)
        .opacity(card.isFaceUp || !card.isMatched ? 1:0)
    }
}

struct CardView_Previews: PreviewProvider {
    typealias Card = MemoryGame<String>.Card // this actually creates a new type
    
    static var previews: some View {
        VStack {
            HStack {
                CardView(card: Card(isFaceUp: true, isMatched: false, content: "🤮", id: "test1")).padding()
                CardView(card: Card(isFaceUp: false, isMatched: false, content: "🤮", id: "test1")).padding()
            }
            HStack {
                CardView(card: Card(isFaceUp: true, isMatched: false, content: "🤮", id: "test1")).padding()
                CardView(card: Card(isFaceUp: false, isMatched: false, content: "🤮", id: "test1")).padding()
            }
        }
    }
}
