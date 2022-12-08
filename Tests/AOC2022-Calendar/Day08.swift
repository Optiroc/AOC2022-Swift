import XCTest
@testable import AOC2022

final class Day08: XCTestCase {
    /// Sample input
    ///
    /// https://adventofcode.com/2022/day/8
    let sampleInput = PuzzleInput.getLines(name: "day08_sample")
        .compactMap { $0.count > 0 ? $0 : nil }

    /// Puzzle input
    ///
    /// https://adventofcode.com/2022/day/8/input
    let puzzleInput = PuzzleInput.getLines(name: "day08_input")
        .compactMap { $0.count > 0 ? $0 : nil }

    func testDay07Part1() {
        let sampleMatrix = Matrix.load(sampleInput)
        let sampleVisible = TreeHouse.scanVisibleTrees(in: sampleMatrix)

        let puzzleMatrix = Matrix.load(puzzleInput)
        let puzzleVisible = TreeHouse.scanVisibleTrees(in: puzzleMatrix)

        print("08.1a Visible trees in sample:", sampleVisible)
        print("08.1b Visible trees in puzzle:", puzzleVisible)

        XCTAssertEqual(21, sampleVisible)
        XCTAssertEqual(1690, puzzleVisible)
    }

    func testDay07Part2() {
        let sampleMatrix = Matrix.load(sampleInput)
        let sampleScore = TreeHouse.maxScenicScore(in: sampleMatrix)

        let puzzleMatrix = Matrix.load(puzzleInput)
        let puzzleScore = TreeHouse.maxScenicScore(in: puzzleMatrix)

        print("08.2a Max scenic score in sample:", sampleScore)
        print("08.2b Max scenic score in puzzle:", puzzleScore)

        XCTAssertEqual(8, sampleScore)
        XCTAssertEqual(535680, puzzleScore)
    }
}
