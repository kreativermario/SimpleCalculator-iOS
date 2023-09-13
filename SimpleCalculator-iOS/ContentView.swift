//
//  ContentView.swift
//  SimpleCalculator-iOS
//
//  Created by Mário Cao on 13/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var display = "0"

    var body: some View {
        VStack(spacing: 20) {
            Text("Simple Calculator")
                .font(.largeTitle)
                .frame(alignment: .center)
                .padding(1)
            Text("by kreativermario")
                .font(.caption)

            CalculatorButtonsView(display: $display)
                .padding(.all, 4.0)
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
