import XCTest
@testable import AOC2022

final class Day11: XCTestCase {
    /// Sample input
    ///
    /// https://adventofcode.com/2022/day/11
    let sampleInput = PuzzleInput.getLines(name: "day11_sample")

    /// Puzzle input
    ///
    /// https://adventofcode.com/2022/day/11/input
    let puzzleInput = PuzzleInput.getLines(name: "day11_input")

    func testDay11Part1() {
        let sampleGang = MonkeyGang<UInt64>(sampleInput)
        let puzzleGang = MonkeyGang<UInt64>(puzzleInput)

        for _ in 1...20 { sampleGang.runTurn() }
        let sampleBusiness = sampleGang.business

        print("11.1a Sample business:", sampleBusiness)
        XCTAssertEqual(10605, sampleBusiness)

        for _ in 1...20 { puzzleGang.runTurn() }
        let puzzleBusiness = puzzleGang.business

        print("11.1b Puzzle business:", puzzleBusiness)
        XCTAssertEqual(110264, puzzleBusiness)
    }

    func testDay11Part2() {
        let sampleGang = MonkeyGang<UInt64>(sampleInput)
        let puzzleGang = MonkeyGang<UInt64>(puzzleInput)

        for _ in 1...10000 { sampleGang.runTurn(nervous: true) }
        let sampleBusiness = sampleGang.business

        print("11.2a Nervous sample business:", sampleBusiness)
        XCTAssertEqual(2713310158, sampleBusiness)

        for _ in 1...10000 { puzzleGang.runTurn(nervous: true) }
        let puzzleBusiness = puzzleGang.business

        print("11.2b Nervous puzzle business:", puzzleBusiness)
        XCTAssertEqual(23612457316, puzzleBusiness)
    }
}
