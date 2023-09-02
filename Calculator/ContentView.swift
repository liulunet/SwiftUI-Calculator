//
//  ContentView.swift
//  Calculator
//
//  Created by liulu on 2023/8/8.
//

import SwiftUI

struct ContentView: View {
    
    @State private var brain: CalculatorBrain = .left("0")
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text(brain.output)
                .font(.system(size: 76))
                .lineLimit(1)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    alignment: .trailing
                )
            CalculatorButtonPad(brain: $brain)
                .padding(.bottom)
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView().previewDevice("iPhone SE (3rd generation)")
            ContentView().previewDevice("iPad Pro (12.9-inch) (6th generation)")
        }
        
    }
}

struct CalculatorButtonPad: View {
    @Binding var brain: CalculatorBrain
    let pad: [[CalculatorButtonItem]] = [
        [.command(.clear), .command(.flip), .command(.percent), .op(.divide)],
        [.digit(7), .digit(8), .digit(9), .op(.multiply)],
        [.digit(4), .digit(5), .digit(6), .op(.minus)],
        [.digit(1), .digit(2), .digit(3), .op(.plus)],
        [.digit(0), .dot, .op(.equal)]
    ]
    var body: some View {
        VStack(spacing: 8) {
            ForEach(pad, id: \.self) { row in
                CalculatorButtonRow(brain: $brain, row: row)
            }
        }
    }
}

struct CalculatorButtonRow: View {
    @Binding var brain: CalculatorBrain
    let row: [CalculatorButtonItem]
    var body: some View {
        HStack {
            ForEach(row, id: \.self) { item in
                CalcularotButton(title: item.title, size: item.size, backgroundColorName: item.backgroundColorName, textColorName: item.textColorName) {
                    self.brain = self.brain.apply(item: item)
                    print("Button: \(item.title)")
                }
            }
        }
    }
}


struct CalcularotButton: View {
    let fontSize: CGFloat = 38
    let title: String
    let size: CGSize
    let backgroundColorName: String
    let textColorName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .font(.system(size: fontSize))
                .foregroundColor(Color(textColorName))
                .frame(width: size.width,height: size.height)
                .background(Color(backgroundColorName))
                .cornerRadius(size.width/2)
        })
    }
}
