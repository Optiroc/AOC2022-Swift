import XCTest
@testable import AOC2022

final class MatrixTests: XCTestCase {
    let matrix = Matrix(rows: 3, columns: 3, sequence: [1,2,3, 4,5,6, 7,8,9])

    func testSequenceConstructor() throws {
        XCTAssertEqual(15, matrix.row(1)!.reduce(0, +))
        XCTAssertEqual(12, matrix.column(0)!.reduce(0, +))

        XCTAssertEqual(24, matrix.row(2)!.lazy.reduce(0, +))
        XCTAssertEqual(15, matrix.column(1)!.lazy.reduce(0, +))

        if let _ = matrix.row(3) { XCTFail("Row out of bounds") }
        if let _ = matrix.row(-1) { XCTFail("Row out of bounds") }

        if let _ = matrix.column(3) { XCTFail("Column out of bounds") }
        if let _ = matrix.column(-1) { XCTFail("Column out of bounds") }
    }
}
