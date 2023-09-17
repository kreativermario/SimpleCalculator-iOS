//
//  ContentView.swift
//  SimpleCalculator-iOS
//
//  Created by Mário Cao on 13/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var display = "0"
    @State private var isMainMenu = true
    @State private var hasDigits = false
    @State private var hasError = false

    var body: some View {
        VStack(spacing: 20) {
            
            if isMainMenu {
                Text("Simple Calculator")
                    .font(.largeTitle)
                    .fontDesign(.serif)
                    .frame(alignment: .center)
                    .padding(1)
                Text("by kreativermario")
                    .fontDesign(.serif)
                    .font(.body)
                NotesView()
            } else {
                CalculatorButtonsView(display: $display, hasDigits: $hasDigits, hasError: $hasError)
                    .padding(.all, 4.0)
            }
            Button(action: changeMenu){
                Label(isMainMenu ? "Calculator" : "Main Menu", systemImage: "rectangle.portrait.and.arrow.right")
                    .fontDesign(.monospaced)
            }
            .padding(.top, 2.0)
            .font(.title)
            .buttonStyle(.bordered)
        }
    }
    
    func changeMenu(){
        isMainMenu.toggle()
    }
}

struct NotesView: View {
    var body: some View {
        List {
            Text("Developer notes")
                .font(.headline)
                .fontDesign(.monospaced)
            Text("Percentage function not implemented")
                .fontDesign(.monospaced)
            Text("Dividing integers will round (8/5 = 1). But if user inputs one double like 8.0/5 = 1.6")
                .fontDesign(.monospaced)
            Text("No decimal separators implemented yet")
                .fontDesign(.monospaced)
            Text("The default decimal separator is **(dot)** `.` and the thousands separator is **(comma)** `,` ")
                .fontDesign(.monospaced)
        }
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
