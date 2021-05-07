//
//  ContentView.swift
//  Spotify Redesign
//
//  Created by Osaretin Uyigue on 4/27/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
        // always dark mode...
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
