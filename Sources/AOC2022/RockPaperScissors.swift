//
//  RockPaperScissors.swift
//  Created by David Lindecrantz on 2022-12-06.
//

public enum RockPaperScissors {
    case rock
    case paper
    case scissors

    var value: Int {
        switch self {
        case .rock: return 1
        case .paper: return 2
        case .scissors: return 3
        }
    }

    static func winning(over shape: Self) -> Self {
        switch shape {
        case .rock: return .paper
        case .paper: return .scissors
        case .scissors: return .rock
        }
    }

    static func losing(over shape: Self) -> Self {
        switch shape {
        case .rock: return .scissors
        case .paper: return .rock
        case .scissors: return .paper
        }
    }

    static func from(_ s: Character) -> Self {
        switch s {
        case "A", "X": return .rock
        case "B", "Y": return .paper
        case "C", "Z": return .scissors
        default:
            fatalError("Unknown strategy token '\(s)'")
        }
    }

    static func pairFrom(_ s: String) -> (Self, Self) {
        (from(s.first!), from(s.last!))
    }

    static func score(_ pair: (Self, Self)) -> Int {
        let outcome: Int
        switch pair {
        case (.scissors, .rock), (.rock, .paper), (.paper, .scissors): outcome = 6
        case let (x, y) where x == y: outcome = 3
        default: outcome = 0
        }

        return outcome + pair.1.value
    }

    // MARK: - Day 2 rules

    enum Outcome {
        case lose
        case draw
        case win

        static func from(_ s: Character) -> Self {
            switch s {
            case "X": return .lose
            case "Y": return .draw
            case "Z": return .win
            default: fatalError("Unknown strategy token '\(s)'")
            }
        }

        var value: Int {
            switch self {
            case .lose: return 0
            case .draw: return 3
            case .win: return 6
            }
        }
    }

    static func strategyPairFrom(_ s: String) -> (Self, Self.Outcome) {
        (from(s.first!), Outcome.from(s.last!))
    }

    static func score(_ pair: (Self, Self.Outcome)) -> Int {
        let shape: Self
        switch pair {
        case (let otherShape, .win): shape = winning(over: otherShape)
        case (let otherShape, .lose): shape = losing(over: otherShape)
        case (let otherShape, .draw): shape = otherShape
        }

        return pair.1.value + shape.value
    }
}
