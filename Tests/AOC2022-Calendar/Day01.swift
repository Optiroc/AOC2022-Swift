import XCTest
@testable import AOC2022

final class Day01: XCTestCase {
    /// Sample input
    ///
    /// https://adventofcode.com/2022/day/1
    let sampleInput = PuzzleInput.getLines(name: "day01_sample")

    /// Puzzle input
    ///
    /// https://adventofcode.com/2022/day/1/input
    let puzzleInput = PuzzleInput.getLines(name: "day01_input")

    func countCalories(_ input: [String]) -> [Int] {
        input
            .map { Int($0) }
            .split(separator: .none)
            .map {
                $0.reduce(into: 0) { $0 += $1 ?? 0 }
            }
    }

    func testDay01Part1() {
        let sampleHarvestMax = countCalories(sampleInput).max() ?? 0

        let puzzleHarvestMax = countCalories(puzzleInput).max() ?? 0

        print("Most calories in sample:", sampleHarvestMax)
        print("Most calories in puzzle:", puzzleHarvestMax)

        XCTAssertEqual(24000, sampleHarvestMax)
        XCTAssertEqual(71780, puzzleHarvestMax)
    }

    func testDay01Part2() {
        let sampleHarvestTop3 = countCalories(sampleInput)
            .sorted(by: { $0 > $1 })[0...2]
            .reduce(0, +)

        let puzzleHarvestTop3 = countCalories(puzzleInput)
            .sorted(by: { $0 > $1 })[0...2]
            .reduce(0, +)

        print("Sum of top three bags in sample:", sampleHarvestTop3)
        print("Sum of top three bags in puzzle:", puzzleHarvestTop3)

        XCTAssertEqual(45000, sampleHarvestTop3)
        XCTAssertEqual(212489, puzzleHarvestTop3)
    }
}
