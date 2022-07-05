//
//  ContentView.swift
//  AddSwiftui
//
//  Created by Alexander Larsen on 05/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var adWidth: CGFloat = 0
    @State private var adHeight: CGFloat = 0

    var body: some View {
        ScrollView {
            Text("Some text")
            AdnuntiusRepresentable(auId: "00000000000b42ef", width: $adWidth, height: $adHeight)
                .frame(width: self.adWidth, height: self.adHeight)
            Text("Some text")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
