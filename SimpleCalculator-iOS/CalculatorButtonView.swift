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
    @Binding var hasError: Bool

    var body: some View {
        VStack {
            Text(display)
                .font(.system(size: 48))
                .multilineTextAlignment(.trailing)
                .lineLimit(5)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .fontWeight(.semibold)
                .foregroundColor(hasError ? .red : .black)
                .bold()
                .padding(.trailing, 50)
                .padding(.bottom, 15.0)
            HStack(spacing: 5) {
                CalculatorButton(label: hasDigits ? "C" :"A/C", action: hasDigits ? deleteDigit : resetDigits)
                CalculatorButton(label: "+/-", action: flipSignal)
                CalculatorButton(label: "%", action: appendDigit)
                CalculatorButton(label: "/", action: appendOperator)
            }
            HStack(spacing: 5) {
                CalculatorButton(label: "7", action: appendDigit)
                CalculatorButton(label: "8", action: appendDigit)
                CalculatorButton(label: "9", action: appendDigit)
                CalculatorButton(label: "*", action: appendOperator)
            }
            HStack(spacing: 5) {
                CalculatorButton(label: "4", action: appendDigit)
                CalculatorButton(label: "5", action: appendDigit)
                CalculatorButton(label: "6", action: appendDigit)
                CalculatorButton(label: "-", action: appendOperator)
            }
            HStack(spacing: 5) {
                CalculatorButton(label: "1", action: appendDigit)
                CalculatorButton(label: "2", action: appendDigit)
                CalculatorButton(label: "3", action: appendDigit)
                CalculatorButton(label: "+", action: appendOperator)
            }
            HStack(spacing: 3) {
                ZeroButton(label: "0", action: appendDigit)
                CalculatorButton(label: ".", action: appendDecimal)
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
            display = "" + display
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
        if hasError {
            hasError = false
            display = String(0)
        }
        
        if display == "0" {
            hasDigits = true
            display = digit
        } else {
            display += digit
        }
    }
    
    func appendDecimal(_ _: String) {
        display += "."
    }

        
    func appendOperator(_ operatorSymbol: String) {
        display += operatorSymbol
    }
    
    func errorHandler(errorMessage: String) {
        display = errorMessage
        hasDigits = false
        hasError = true
    }
    
    func calculateResult(_ : String) {
        // Check for division by zero
        if display.contains("/0") {
            errorHandler(errorMessage: "Error: Division by zero")
            return
        }
        
        // Display variable contains the expression
        let expr = NSExpression(format: display)
        
        if let value = expr.expressionValue(with: nil, context: nil) as? NSNumber {
            let doubleValue = value.doubleValue
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            if let formattedResult = formatter.string(from: NSNumber(value: doubleValue)) {
                display = formattedResult
            } else {
                errorHandler(errorMessage: "Error: Formatting")
                return
            }
        } else {
            errorHandler(errorMessage: "Unknown Error")
        }
    }


}

struct ZeroButton: View {
    let label: String
    let action: (String) -> Void

    @State private var isPressed = false

    var body: some View {
        Button(action: {
            action(label)
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
            }
        }) {
            Text(label)
                .font(.title)
                .frame(width: 80 * 2 + 20, height: 80)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(40)
                .scaleEffect(isPressed ? 0.8 : 1.0)
                .shadow(color: .gray, radius: 0.5)

        }
    }
}


struct CalculatorButton: View {
    let label: String
    let action: (String) -> Void

    @State private var isPressed = false

    var body: some View {
        Button(action: {
            action(label)
            isPressed = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
            }
        }) {
            Text(label)
                .font(.title)
                .frame(width: 80, height: 80)
                .background(.black)
                .foregroundColor(.white)
                .cornerRadius(40)
                .scaleEffect(isPressed ? 0.8 : 1.0)
        }
    }
}
