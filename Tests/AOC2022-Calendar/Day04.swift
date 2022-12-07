import Algorithms
import XCTest
@testable import AOC2022

final class Day04: XCTestCase {
    /// Sample input
    ///
    /// https://adventofcode.com/2022/day/4
    let sampleInput = PuzzleInput.getLines(name: "day04_sample")
        .compactMap { $0.count > 0 ? $0 : nil }

    /// Puzzle input
    ///
    /// https://adventofcode.com/2022/day/4/input
    let puzzleInput = PuzzleInput.getLines(name: "day04_input")
        .compactMap { $0.count > 0 ? $0 : nil }

    func getRangePairs(_ input: [String]) -> [(ClosedRange<Int>, ClosedRange<Int>)] {
        input
            .map {
                $0.components(separatedBy: ",").map { makeRange($0) }
            }
            .map { ($0[0], $0[1]) }
    }

    func makeRange(_ string: String) -> ClosedRange<Int> {
        let pair = string.components(separatedBy: "-").compactMap { Int($0) }
        return pair[0]...pair[1]
    }

    func isOverlapping(_ ranges: (ClosedRange<Int>, ClosedRange<Int>)) -> Bool {
        ranges.0.overlaps(ranges.1) || ranges.1.overlaps(ranges.0)
    }

    func isFullyOverlapping(_ ranges: (ClosedRange<Int>, ClosedRange<Int>)) -> Bool {
        ranges.0.lowerBound >= ranges.1.lowerBound && ranges.0.upperBound <= ranges.1.upperBound ||
        ranges.1.lowerBound >= ranges.0.lowerBound && ranges.1.upperBound <= ranges.0.upperBound
    }

    func testDay04Part1() {
        let sampleOverlappingRanges = getRangePairs(sampleInput)
            .reduce(into: 0) { $0 += isFullyOverlapping($1) ? 1 : 0 }

        let puzzleOverlappingRanges = getRangePairs(puzzleInput)
            .reduce(into: 0) { $0 += isFullyOverlapping($1) ? 1 : 0 }

        print("04.1a Fully overlapping ranges in sample:", sampleOverlappingRanges)
        print("04.1b Fully overlapping ranges in puzzle:", puzzleOverlappingRanges)

        XCTAssertEqual(2, sampleOverlappingRanges)
        XCTAssertEqual(431, puzzleOverlappingRanges)
    }

    func testDay04Part2() {
        let sampleOverlappingRanges = getRangePairs(sampleInput)
            .reduce(into: 0) { $0 += isOverlapping($1) ? 1 : 0 }

        let puzzleOverlappingRanges = getRangePairs(puzzleInput)
            .reduce(into: 0) { $0 += isOverlapping($1) ? 1 : 0 }

        print("04.2a Overlapping ranges in sample:", sampleOverlappingRanges)
        print("04.2b Overlapping ranges in puzzle:", puzzleOverlappingRanges)

        XCTAssertEqual(4, sampleOverlappingRanges)
        XCTAssertEqual(823, puzzleOverlappingRanges)
    }
}
