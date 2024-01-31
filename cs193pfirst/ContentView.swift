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
            cards
            cardCountAdjusters
    }
        

        }
    
    var cards: some View {
        HStack {
            ForEach(0..<cardCount, id: \.self) {index in
                CardView(content: emojis[index], description: emojisDescription[index])
            }
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        .padding()
        
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardAdder
            Spacer()
            cardRemover


        }    .imageScale(.large)
            .font(.largeTitle)
    }
    
    var cardRemover: some View {
        Button(action: {
            if cardCount > 1 {
                cardCount -= 1
            }
        }, label: {
            Image(systemName: "minus")
        })
        .padding()
    }
    
    var cardAdder: some View {
        Button(action: {
            if cardCount < emojis.count {
                cardCount += 1
            }
        }, label: {
            Image(systemName: "plus")
        }).padding()
    }
    
}

struct CardView: View {
    let content: String
    let description: String
    @State var isFaceUp: Bool = false
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .strokeBorder(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                VStack {
                    Text(content)
                        .font(.largeTitle)
                    Text(description).font(.footnote)
                }
            }
            else
            {RoundedRectangle(cornerRadius: 25.0).fill()
            }
        }.onTapGesture {
            isFaceUp.toggle()
        }
        .foregroundColor(.teal)
    }
}






#Preview {
    ContentView()
}
