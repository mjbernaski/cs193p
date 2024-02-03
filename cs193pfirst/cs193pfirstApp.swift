//
//  cs193pfirstApp.swift
//  cs193pfirst
//
//  Created by Michael Bernaski on 1/30/24.
//

import SwiftUI

@main
struct cs193pfirstApp: App {
    @StateObject var game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
