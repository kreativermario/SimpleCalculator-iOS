//
//  ContentView.swift
//  SimpleCalculator-iOS
//
//  Created by Mário Cao on 13/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var display = "0"
    @State private var hasDigits = false
    @State private var hasError = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Simple Calculator")
                .font(.largeTitle)
                .frame(alignment: .center)
                .padding(1)
            Text("by kreativermario")
                .font(.body)

            CalculatorButtonsView(display: $display, hasDigits: $hasDigits, hasError: $hasError)
                .padding(.all, 4.0)
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
