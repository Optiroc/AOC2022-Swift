import XCTest
@testable import AOC2022

final class Day06: XCTestCase {
    /// Sample input
    ///
    /// https://adventofcode.com/2022/day/6
    let sampleInput = Array(PuzzleInput.getLines(name: "day06_sample").first!)

    /// Puzzle input
    ///
    /// https://adventofcode.com/2022/day/6/input
    let puzzleInput = Array(PuzzleInput.getLines(name: "day06_input").first!)

    func detectStartOfPacket(_ input: [Character], markerSize: Int = 4) -> Int {
        for i in 0...input.count - markerSize {
            let window = input[i..<i + markerSize]
            if Set(window).count == markerSize {
                return i + markerSize
            }
        }
        fatalError("Start of packet market not found")
    }

    func testDay06Part1() {
        let sampleMarker = detectStartOfPacket(sampleInput)
        let puzzleMarker = detectStartOfPacket(puzzleInput)

        print("06.1a Sample first marker at:", sampleMarker)
        print("06.1b Puzzle first marker at:", puzzleMarker)

        XCTAssertEqual(7, sampleMarker)
        XCTAssertEqual(1175, puzzleMarker)
    }

    func testDay06Part2() {
        let sampleMarker = detectStartOfPacket(Array("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"), markerSize: 14)
        let puzzleMarker = detectStartOfPacket(puzzleInput, markerSize: 14)

        print("06.2a Sample first message at:", sampleMarker)
        print("06.2b Puzzle first message at:", puzzleMarker)

        XCTAssertEqual(29, sampleMarker)
        XCTAssertEqual(3217, puzzleMarker)
    }
}
