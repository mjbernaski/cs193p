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
        TimelineView(.animation(minimumInterval: 1/5)) { timeline in
            if card.isFaceUp || !card.isMatched {
                Pie(endAngle: Angle.degrees(card.bonusPercentRemaining * 360))
                    .opacity(0.4)
                    .overlay(
                        cardContents.padding(5)
                    )
                    .padding(5)
                //    .modifier(Cardify(isFaceUp: card.isFaceUp))
                    .cardify(isFaceUp: card.isFaceUp)
                    .foregroundColor(.teal)
                    .transition(.scale)
            } else {
                Color.clear
            }
        }
    }
    
    var cardContents: some View {
        Text(card.content)
            .font(
                .system(size: 200))
            .minimumScaleFactor(0.01)
            .aspectRatio(1, contentMode:.fit)
            .rotationEffect(.degrees(card.isMatched ? 360: 0))
            .animation(.spin(duration: 1), value: card.isMatched)
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
