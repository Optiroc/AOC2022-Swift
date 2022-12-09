import XCTest
@testable import AOC2022

final class Day09: XCTestCase {
    /// Sample input
    ///
    /// https://adventofcode.com/2022/day/9
    let sampleInput = PuzzleInput.getLines(name: "day09_sample")
        .compactMap { $0.count > 0 ? $0 : nil }

    /// Puzzle input
    ///
    /// https://adventofcode.com/2022/day/9/input
    let puzzleInput = PuzzleInput.getLines(name: "day09_input")
        .compactMap { $0.count > 0 ? $0 : nil }

    func testDay09Part1() {
        let sampleRope = Rope(length: 2).apply(moves: sampleInput)
        let puzzleRope = Rope(length: 2).apply(moves: puzzleInput)

        print("09.1a Positions covered in sample:", sampleRope.coverage)
        print("09.1b Positions covered in puzzle:", puzzleRope.coverage)

        XCTAssertEqual(13, sampleRope.coverage)
        XCTAssertEqual(6494, puzzleRope.coverage)
    }

    func testDay09Part2() {
        let sampleRope = Rope(length: 10).apply(moves: sampleInput)
        let puzzleRope = Rope(length: 10).apply(moves: puzzleInput)

        print("09.2a Positions covered in sample:", sampleRope.coverage)
        print("09.2b Positions covered in puzzle:", puzzleRope.coverage)

        XCTAssertEqual(1, sampleRope.coverage)
        XCTAssertEqual(2691, puzzleRope.coverage)
    }
}
