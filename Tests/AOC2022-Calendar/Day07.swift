import XCTest
@testable import AOC2022

final class Day07: XCTestCase {
    /// Sample input
    ///
    /// https://adventofcode.com/2022/day/7
    let sampleInput = PuzzleInput.getLines(name: "day07_sample")

    /// Puzzle input
    ///
    /// https://adventofcode.com/2022/day/7/input
    let puzzleInput = PuzzleInput.getLines(name: "day07_input")

    func testDay07Part1() {
        let maxSize = 100_000

        let sampleFS = ElfFS().populate(from: sampleInput)
        let sampleSum = sampleFS.root.rnodes
            .filter { $0.type == .directory }
            .filter { $0.rsize <= maxSize }
            .reduce(into: 0) { $0 += $1.rsize }

        let puzzleFS = ElfFS().populate(from: puzzleInput)
        let puzzleSum = puzzleFS.root.rnodes
            .filter { $0.type == .directory }
            .filter { $0.rsize <= maxSize }
            .reduce(into: 0) { $0 += $1.rsize }

        print("07.1a Sum of small dirs in sample:", sampleSum)
        print("07.1b Sum of small dirs in puzzle:", puzzleSum)

        XCTAssertEqual(95437, sampleSum)
        XCTAssertEqual(1844187, puzzleSum)
    }

    func testDay07Part2() {
        let totalSize = 70_000_000
        let targetFreeSize = 30_000_000

        let sampleFS = ElfFS().populate(from: sampleInput)
        let samplePurgeSize = targetFreeSize - (totalSize - sampleFS.root.rsize)
        let sampleDeletion = sampleFS.root.rnodes
            .filter { $0.type == .directory }
            .filter { $0.rsize >= samplePurgeSize }
            .sorted(by: { $0.rsize > $1.rsize })
            .last!.rsize

        let puzzleFS = ElfFS().populate(from: puzzleInput)
        let puzzlePurgeSize = targetFreeSize - (totalSize - puzzleFS.root.rsize)
        let puzzleDeletion = puzzleFS.root.rnodes
            .filter { $0.type == .directory }
            .filter { $0.rsize >= puzzlePurgeSize }
            .sorted(by: { $0.rsize > $1.rsize })
            .last!.rsize

        print("07.2a Dir size for deletion in sample:", sampleDeletion)
        print("07.2b Dir size for deletion in puzzle:", puzzleDeletion)

        XCTAssertEqual(24933642, sampleDeletion)
        XCTAssertEqual(4978279, puzzleDeletion)
    }
}
