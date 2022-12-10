import XCTest
@testable import AOC2022

final class Day10: XCTestCase {
    /// Sample input
    ///
    /// https://adventofcode.com/2022/day/10
    let sampleInput = PuzzleInput.getLines(name: "day10_sample")
        .compactMap { $0.count > 0 ? $0 : nil }

    /// Puzzle input
    ///
    /// https://adventofcode.com/2022/day/10/input
    let puzzleInput = PuzzleInput.getLines(name: "day10_input")
        .compactMap { $0.count > 0 ? $0 : nil }

    func testDay10Part1() {
        let sampleSignal = ElfCPU(program: sampleInput)
            .run(ticks: [20, 60, 100, 140, 180, 220])
            .sum()
        print("10.1a Sum of signal strengths in sample:", sampleSignal)
        XCTAssertEqual(13140, sampleSignal)

        let puzzleSignal = ElfCPU(program: puzzleInput)
            .run(ticks: [20, 60, 100, 140, 180, 220])
            .sum()
        print("10.1a Sum of signal strengths in puzzle:", puzzleSignal)
        XCTAssertEqual(12880, puzzleSignal)
    }

    func testDay10Part2() {
        let sampleCPU = ElfCPU(program: sampleInput)
        sampleCPU.runUntilEOP()
        print(sampleCPU.frameBuffer.joined(separator: "\n"))

        XCTAssertEqual(sampleCPU.frameBuffer, [
            "##..##..##..##..##..##..##..##..##..##..",
            "###...###...###...###...###...###...###.",
            "####....####....####....####....####....",
            "#####.....#####.....#####.....#####.....",
            "######......######......######......####",
            "#######.......#######.......#######....."
        ])

        let puzzleCPU = ElfCPU(program: puzzleInput)
        puzzleCPU.runUntilEOP()
        print(puzzleCPU.frameBuffer.joined(separator: "\n"))

        XCTAssertEqual(puzzleCPU.frameBuffer, [
            "####..##....##..##..###....##.###..####.",
            "#....#..#....#.#..#.#..#....#.#..#.#....",
            "###..#.......#.#..#.#..#....#.#..#.###..",
            "#....#.......#.####.###.....#.###..#....",
            "#....#..#.#..#.#..#.#....#..#.#.#..#....",
            "#.....##...##..#..#.#.....##..#..#.####."
        ])
    }
}
