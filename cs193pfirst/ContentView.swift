//
//  ContentView.swift
//  MyFirst193PApp
//
//  Created by Michael Bernaski on 1/30/24.
//

import SwiftUI

struct ContentView: View {
    let emojis:[String] = ["😇", "👁️","🦾","😁"]
    var body: some View {
        HStack {
            
            ForEach(emojis.indices, id: \.self) {index in
                CardView(content: emojis[index])
            }
 
        }
        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        .padding()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.white)
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .strokeBorder(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                Text(content)
                    .font(.largeTitle)
            }
            else
            {RoundedRectangle(cornerRadius: 25.0).fill()
            }
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}






#Preview {
    ContentView()
}
