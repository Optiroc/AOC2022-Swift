import XCTest
@testable import AOC2022

final class Day02: XCTestCase {
    /// Sample input
    ///
    /// https://adventofcode.com/2022/day/2
    let sampleInput = PuzzleInput.getLines(name: "day02_sample")
        .compactMap { $0.count > 0 ? $0 : nil }

    /// Puzzle input
    ///
    /// https://adventofcode.com/2022/day/2/input
    let puzzleInput = PuzzleInput.getLines(name: "day02_input")
        .compactMap { $0.count > 0 ? $0 : nil }

    func testDay02Part1() {
        let sampleScore = sampleInput
            .map { RockPaperScissors.pairFrom($0) }
            .reduce(into: 0) { $0 += RockPaperScissors.score($1) }

        let puzzleScore = puzzleInput
            .map { RockPaperScissors.pairFrom($0) }
            .reduce(into: 0) { $0 += RockPaperScissors.score($1) }

        print("02.1a Score following sample strategy:", sampleScore)
        print("02.1b Score following puzzle strategy:", puzzleScore)

        XCTAssertEqual(15, sampleScore)
        XCTAssertEqual(13221, puzzleScore)
    }

    func testDay02Part2() {
        let sampleScore = sampleInput
            .map { RockPaperScissors.strategyPairFrom($0) }
            .reduce(into: 0) { $0 += RockPaperScissors.score($1) }

        let puzzleScore = puzzleInput
            .map { RockPaperScissors.strategyPairFrom($0) }
            .reduce(into: 0) { $0 += RockPaperScissors.score($1) }

        print("02.2a Score following sample crypted strategy:", sampleScore)
        print("02.2b Score following puzzle crypted strategy:", puzzleScore)

        XCTAssertEqual(12, sampleScore)
        XCTAssertEqual(13131, puzzleScore)
    }
}
