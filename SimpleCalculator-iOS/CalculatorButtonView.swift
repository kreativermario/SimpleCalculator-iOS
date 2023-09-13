//
//  CalculatorButtonView.swift
//  SimpleCalculator-iOS
//
//  Created by Mário Cao on 13/09/2023.
//

import Foundation
import SwiftUI

struct CalculatorButtonsView: View {
    @Binding var display: String
    @Binding var hasDigits: Bool

    var body: some View {
        VStack {
            Text(display)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.leading)
                .bold()
                .padding(.bottom, 3.0)
            HStack(spacing: 3) {
                CalculatorButton(label: hasDigits ? "C" :"A/C", action: hasDigits ? deleteDigit : resetDigits)
                CalculatorButton(label: "+/-", action: flipSignal)
                CalculatorButton(label: "%", action: appendDigit)
                CalculatorButton(label: "/", action: appendOperator)
            }
            HStack(spacing: 3) {
                CalculatorButton(label: "7", action: appendDigit)
                CalculatorButton(label: "8", action: appendDigit)
                CalculatorButton(label: "9", action: appendDigit)
                CalculatorButton(label: "*", action: appendOperator)
            }
            HStack(spacing: 3) {
                CalculatorButton(label: "4", action: appendDigit)
                CalculatorButton(label: "5", action: appendDigit)
                CalculatorButton(label: "6", action: appendDigit)
                CalculatorButton(label: "-", action: appendOperator)
            }
            HStack(spacing: 3) {
                CalculatorButton(label: "1", action: appendDigit)
                CalculatorButton(label: "2", action: appendDigit)
                CalculatorButton(label: "3", action: appendDigit)
                CalculatorButton(label: "+", action: appendOperator)
            }
            HStack(spacing: 3) {
                ZeroButton(label: "0", action: appendDigit)
                CalculatorButton(label: ",", action: appendDecimal)
                CalculatorButton(label: "=", action: calculateResult)
            }

            

            
        }
    }
    
    func deleteDigit(_ digit: String){
        if hasDigits {
            display.removeLast()
            
            // If the display is empty, set it to "0" and mark that there are no digits
            if display.isEmpty {
                display = String(0)
                hasDigits = false
            }
        }
    }
    
    func flipSignal(_ digit: String){
        if display.hasPrefix("-"){
            display.removeFirst()
            var flipped = "" + display
            display = flipped
        }else if display.hasPrefix(""){
            display = "-" + display
        }
        
    }
    
    
    func resetDigits(_ digit: String) {
        if digit.contains("A/C"){
            display = String(0)
            hasDigits = false
        }
    }
    

    func appendDigit(_ digit: String) {
        if display == "0" {
            hasDigits = true
            display = digit
        } else {
            display += digit
        }
    }
    
    func appendDecimal(_ _: String) {
        if !display.contains(",") {
            display += ","
        }
    }

        
    func appendOperator(_ operatorSymbol: String) {
        display += operatorSymbol
    }
    
    func calculateResult(_ _: String) {
        // Check for division by zero
        if display.contains("/0") {
            display = "Error: Division by zero"
            return
        }
        
        // display variable contains the expression
        let expression = NSExpression(format: display)
        
        if let result = expression.expressionValue(with: nil, context: nil) as? NSNumber {
            // Update the display with the calculated result
            display = result.stringValue
        } else {
            // Handle error or invalid expression
            display = "Error"
        }
    }

}

struct ZeroButton: View {
    let label: String
    let action: (String) -> Void

    var body: some View {
        Button(action: {
            action(label)
        }) {
            Text(label)
                .font(.title)
                .frame(width: 80 * 2 + 20, height: 80) // Adjust height for double slot
                .background(Color.black)
                .foregroundColor(Color.yellow)
                .cornerRadius(40)
                .animation(.default, value: 0.5)
                .scaleEffect(0.8)
                .shadow(radius: 1)
        }
    }
}


struct CalculatorButton: View {
    let label: String
    let action: (String) -> Void

    var body: some View {
        Button(action: {
            action(label)
        }) {
            Text(label)
                .font(.title)
                .frame(width: 80, height: 80)
                .background(Color.black)
                .foregroundColor(Color.yellow)
                .cornerRadius(40)
                .animation(.default, value: 0.5)
                .scaleEffect(0.8)
                .shadow(radius: 1)
        }
    }
}
