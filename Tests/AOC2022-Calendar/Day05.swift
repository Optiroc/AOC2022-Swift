import XCTest
@testable import AOC2022

final class Day05: XCTestCase {
    /// Sample input
    ///
    /// https://adventofcode.com/2022/day/5
    let sampleInput = PuzzleInput.getLines(name: "day05_sample")

    /// Puzzle input
    ///
    /// https://adventofcode.com/2022/day/5/input
    let puzzleInput = PuzzleInput.getLines(name: "day05_input")

    func parseInput(_ input: [String]) -> (SupplyStacks<Character>, [(Int, Int, Int)]) {
        let base = input.split(separator: "")
        var state = Array(base[0])
        let index = state.popLast()!
        let columns = Int(index.split(separator: " ").last!)!

        let stacks = SupplyStacks<Character>(stacks: columns)

        for row in state {
            let chars = Array(row).map { $0.isWhitespace ? nil : $0 }
            for column in 0..<columns {
                if let char = chars.at(1 + column * 4), let char {
                    stacks.insert(element: char, into: column)
                }
            }
        }

        let moves = base[1].map {
            let words = $0.components(separatedBy: .whitespaces)
            return (Int(words[1])!, Int(words[3])! - 1, Int(words[5])! - 1)
        }

        return (stacks, moves)
    }

    func testDay05Part1() {
        let (sampleStack, sampleMoves) = parseInput(sampleInput)
        for move in sampleMoves {
            sampleStack.move(amount: move.0, from: move.1, to: move.2)
        }

        let (puzzleStack, puzzleMoves) = parseInput(puzzleInput)
        for move in puzzleMoves {
            puzzleStack.move(amount: move.0, from: move.1, to: move.2)
        }

        print("05.1a Sample crate word:", sampleStack.word)
        print("05.1b Puzzle crate word:", puzzleStack.word)

        XCTAssertEqual("CMZ", sampleStack.word)
        XCTAssertEqual("FCVRLMVQP", puzzleStack.word)
    }

    func testDay05Part2() {
        let (sampleStack, sampleMoves) = parseInput(sampleInput)
        for move in sampleMoves {
            sampleStack.move9001(amount: move.0, from: move.1, to: move.2)
        }

        let (puzzleStack, puzzleMoves) = parseInput(puzzleInput)
        for move in puzzleMoves {
            puzzleStack.move9001(amount: move.0, from: move.1, to: move.2)
        }

        print("05.2a Sample crate word:", sampleStack.word)
        print("05.2b Puzzle crate word:", puzzleStack.word)

        XCTAssertEqual("MCD", sampleStack.word)
        XCTAssertEqual("RWLWGJGFD", puzzleStack.word)
    }
}
