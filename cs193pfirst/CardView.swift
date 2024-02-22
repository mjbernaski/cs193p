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
        TimelineView(.animation) { timeline in
            Pie(endAngle: Angle.degrees(card.bonusPercentRemaining * 360))
                .opacity(0.4)
                .overlay(
                    Text(card.content)
                        .font(
                            .system(size: 200))
                        .minimumScaleFactor(0.01)
                        .aspectRatio(1, contentMode:.fit)
                        .padding(5)
                        .rotationEffect(.degrees(card.isMatched ? 360: 0))
                        .animation(.spin(duration: 1), value: card.isMatched)
                )
                .padding(5)
            //    .modifier(Cardify(isFaceUp: card.isFaceUp))
                .cardify(isFaceUp: card.isFaceUp)
                .foregroundColor(.teal)
                .opacity(card.isFaceUp || !card.isMatched ? 1:0)
        }
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


extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration:1).repeatForever(autoreverses: false)
    }
}
