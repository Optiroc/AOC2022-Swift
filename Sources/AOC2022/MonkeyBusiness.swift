//
//  MonkeyBusiness.swift
//  Created by David Lindecrantz on 2022-12-12.
//

import Foundation

class MonkeyGang<T: FixedWidthInteger> {
    let monkeys: [Monkey<T>]
    let lcd: T

    var activity: [T] { monkeys.map { $0.inspections }.sorted() }

    var business: T {
        let act = activity
        return act[act.count - 1] * act[act.count - 2]
    }

    init(_ input: [String]) {
        self.monkeys = input.split(separator: "").map { Monkey(input: Array($0)) }
        self.lcd = monkeys.reduce(into: 1) { $0 = ($0 % $1.divisor == 0) ? $0 : $0 * $1.divisor }
    }

    func runTurn(nervous: Bool = false) {
        for i in 0..<monkeys.count {
            while let item = monkeys[i].items.popLast() {
                let applied: T
                if nervous {
                    applied = monkeys[i].operation.apply(on: item) % lcd
                } else {
                    applied = (monkeys[i].operation.apply(on: item) / 3) % lcd
                }
                let target = applied % monkeys[i].divisor == 0 ? monkeys[i].target.0 : monkeys[i].target.1
                monkeys[target].items.append(applied)
                monkeys[i].inspections += 1
            }
        }
    }
}

class Monkey<T: FixedWidthInteger> {
    enum Operation {
        case add(T)
        case mul(T)
        case sqr

        func apply(on value: T) -> T {
            switch self {
            case .add(let a): return value + a
            case .mul(let a): return value * a
            case .sqr: return value * value
            }
        }
    }

    var items = [T]()
    var inspections: T = 0
    let operation: Operation
    let divisor: T
    let target: (Int, Int)

    init(input: [String]) {
        var items: [T]?
        var op: Operation?
        var div: T?
        var targetTrue: Int?
        var targetFalse: Int?

        for line in input {
            let words = line.components(separatedBy: [" ", ",", ":"]).filter { $0.count > 0 }
            guard words.count > 1 else { continue }

            switch (words[0], words[1]) {
            case ("Starting", "items"):
                items = words.compactMap { T($0) }
            case ("Operation", "new"):
                switch (words[words.count - 2], words.last!) {
                case ("*", "old"): op = .sqr
                case ("+", _): op = .add(T(words.last!)!)
                case ("*", _): op = .mul(T(words.last!)!)
                default: break
                }
            case ("Test", "divisible"):
                div = T(words.last!)
            case ("If", "true"):
                targetTrue = Int(words.last!)
            case ("If", "false"):
                targetFalse = Int(words.last!)
            default: break
            }
        }

        guard let items, let op, let div, let targetTrue, let targetFalse else { fatalError() }
        self.items = items
        self.operation = op
        self.divisor = div
        self.target = (targetTrue, targetFalse)
    }
}

extension MonkeyGang: CustomDebugStringConvertible {
    var debugDescription: String {
        monkeys.reduce(into: "") { $0 += "\($1)\n" }
    }
}

extension Monkey: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(inspections) \(items) :: \(operation) \(divisor) \(target)"
    }
}
