//
//  ContentView.swift
//  MyFirst193PApp
//
//  Created by Michael Bernaski on 1/30/24.
//

import SwiftUI

struct ContentView: View {
    let emojis:[String] = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐵", "🦄", "🐔", "🐧", "🐦", "🐺"]
    let emojisDescription:[String] = ["Dog", "Cat", "Mouse", "Hamster", "Rabbit", "Fox", "Bear", "Panda", "Koala", "Tiger", "Lion", "Cow", "Pig", "Frog", "Monkey", "Unicorn", "Chicken", "Penguin", "Bird", "Wolf"]
    
    
    @State var cardCount = 4
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
            ForEach(0..<cardCount, id: \.self) {index in
                CardView(content: emojis[index], description: emojisDescription[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        .padding()
        
    }
    

}

struct CardView: View {
    let content: String
    let description: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 1)
                    VStack {
                        Text(content).font(.largeTitle)
                        Text(description).font(.footnote)
                    }
                }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0: 1)
            
        }.onTapGesture {
            isFaceUp.toggle()
        }
        .foregroundColor(.teal)
    }
}


#Preview {
    ContentView()
}
