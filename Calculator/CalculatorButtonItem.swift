//
//  CalculatorButtonItem.swift
//  Calculator
//
//  Created by liulu on 2023/8/30.
//

import Foundation
import SwiftUI

enum CalculatorButtonItem {
    enum Op: String {
        case plus = "+"
        case minus = "-"
        case divide = "÷"
        case multiply = "x"
        case equal = "="
    }
    
    enum Command: String {
        case clear = "AC"
        case flip = "+/-"
        case percent = "%"
    }
    
    case digit(Int)
    case dot
    case op(Op)
    case command(Command)
}

extension CalculatorButtonItem {
    var title: String {
        switch self {
        case .digit(let value): return String(value)
        case .dot: return "."
        case .op(let op): return op.rawValue
        case .command(let command): return command.rawValue
        }
    }
    
    var size: CGSize {
        let size: CGFloat = (UIScreen.main.bounds.width-40)/4
        if case .digit(let value) = self, value == 0 {
            return CGSize(width: size * 2 + 8, height: size)
        }
        return CGSize(width: size, height: size)
    }
    
    var backgroundColorName: String {
        switch self {
        case .digit, .dot: return "digitBackground"
        case .op: return "operatorBackground"
        case .command: return "commandBackground"
        }
    }
    
    var textColorName: String {
        switch self {
        case .command: return "commandText"
        case .digit(_): return "universalText"
        case .dot: return "universalText"
        case .op(_): return "universalText"
        }
    }
}

extension CalculatorButtonItem: Hashable {}
extension CalculatorButtonItem: CustomStringConvertible {
    var description: String {
        switch self {
        case .digit(let num): return String(num)
        case .dot: return "."
        case .op(let op): return op.rawValue
        case .command(let command): return command.rawValue
        }
    }
}
