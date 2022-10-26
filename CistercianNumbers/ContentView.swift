//
//  ContentView.swift
//  CistercianNumbers
//
//  Created by nutterfi on 10/25/22.
//

import SwiftUI

struct ContentView: View {
  @State private var isAnimating = false
  var body: some View {
    ZStack {
      CistercianNumber(number: isAnimating ? 5555 : 6789)
        .frame(width: 256, height: 256)
        .animation(.easeInOut(duration: 10).repeatForever(), value: isAnimating)
    }
    .task {
      isAnimating.toggle()
    }
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
