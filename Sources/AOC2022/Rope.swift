//
//  Rope.swift
//  Created by David Lindecrantz on 2022-12-09.
//

class Rope {
    struct Position: Hashable {
        let x: Int
        let y: Int

        func move(_ direction: Direction) -> Self {
            switch direction {
            case .up: return Position(x: x, y: y + 1)
            case .left: return Position(x: x - 1, y: y)
            case .down: return Position(x: x, y: y - 1)
            case .right: return Position(x: x + 1, y: y)
            }
        }

        func follow(_ other: Position) -> Self {
            let cf = abs(x - other.x) + abs(y - other.y) > 2 ? 0 : 1
            return Position(
                x: x + (other.x > x + cf ? 1 : (other.x < x - cf) ? -1 : 0),
                y: y + (other.y > y + cf ? 1 : (other.y < y - cf) ? -1 : 0)
            )
        }
    }

    enum Direction {
        case up, left, down, right

        static func from(_ string: any StringProtocol) -> Self {
            switch string.lowercased() {
            case "u": return .up
            case "l": return .left
            case "d": return .down
            case "r": return .right
            default: fatalError("Direction not recognized")
            }
        }
    }

    var rope: [Position]
    var visited: Set<Position>
    var coverage: Int { visited.count }

    init(length: Int) {
        self.rope = Array(repeating: Position(x: 0, y: 0), count: length)
        self.visited = Set([rope.last!])
    }

    func move(_ direction: Direction) {
        rope[0] = rope[0].move(direction)
        for i in 0..<rope.count - 1 {
            rope[i + 1] = rope[i + 1].follow(rope[i])
        }
        visited.insert(rope.last!)
    }

    func apply(moves: [String]) -> Self {
        for m in moves {
            let c = m.split(separator: " ")
            let (dir, steps) = (Direction.from(c[0]), Int(c[1])!)
            for _ in 1...steps { move(dir) }
        }
        return self
    }
}
