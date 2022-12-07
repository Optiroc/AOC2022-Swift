import Algorithms
import XCTest
@testable import AOC2022

final class Day03: XCTestCase {
    /// Sample input
    ///
    /// https://adventofcode.com/2022/day/3
    let sampleInput = PuzzleInput.getLines(name: "day03_sample")
        .compactMap { $0.count > 0 ? $0 : nil }

    /// Puzzle input
    ///
    /// https://adventofcode.com/2022/day/3/input
    let puzzleInput = PuzzleInput.getLines(name: "day03_input")
        .compactMap { $0.count > 0 ? $0 : nil }
    
    func rucksackItemValue(_ char: Character) -> Int {
        switch char {
        case "a"..."z": return Int(char.asciiValue! - 96)
        case "A"..."Z": return Int(char.asciiValue! - 38)
        default: return 0
        }
    }

    func rucksackCommonItem(_ contents: String) -> Character {
        let sets = contents
            .chunks(ofCount: contents.count / 2)
            .map {
                $0.reduce(into: Set<Character>()) { $0.insert($1) }
            }
        
        if let common = sets[0].intersection(sets[1]).first {
            return common
        } else {
            fatalError("No common character")
        }
    }
    
    func rucksackGroupBadges(_ all: [String]) -> [Character] {
        all.chunks(ofCount: 3)
            .map {
                let sets = $0.map { Set<Character>($0) }
                return sets.reduce(into: sets[0]) { $0 = $0.intersection($1) }.first!
            }
    }
    
    func testDay03Part1() {
        let sampleSum = sampleInput.reduce(into: 0) { $0 += rucksackItemValue(rucksackCommonItem($1)) }
        let puzzleSum = puzzleInput.reduce(into: 0) { $0 += rucksackItemValue(rucksackCommonItem($1)) }

        print("03.1a Sum of sample input:", sampleSum)
        print("03.1b Sum of puzzle input:", puzzleSum)

        XCTAssertEqual(157, sampleSum)
        XCTAssertEqual(7872, puzzleSum)
    }

    func testDay03Part2() {
        let sampleSum = rucksackGroupBadges(sampleInput).reduce(into: 0) { $0 += rucksackItemValue($1) }
        let puzzleSum = rucksackGroupBadges(puzzleInput).reduce(into: 0) { $0 += rucksackItemValue($1) }

        print("03.2a Sum of sample group badges:", sampleSum)
        print("03.2b Sum of puzzle group badges:", puzzleSum)

        XCTAssertEqual(70, sampleSum)
        XCTAssertEqual(2497, puzzleSum)
    }
}
