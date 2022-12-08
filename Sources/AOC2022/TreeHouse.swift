//
//  TreeHouse.swift
//  Created by David Lindecrantz on 2022-12-08.
//

enum TreeHouse {
    static func scanVisibleTrees(in matrix: Matrix<Int>) -> Int {
        var count = 0
        for row in 0..<matrix.rows {
        treeLoop: for column in 0..<matrix.columns {
            // always include edges
            if column == 0 || row == 0 || column == matrix.columns - 1 || row == matrix.rows - 1 {
                count += 1
                continue treeLoop
            }
            // check visibility in cardinal directions
            let height = matrix[column, row]
            if matrix.row(row)!.prefix(column).max()! < height ||
                matrix.column(column)!.prefix(row).max()! < height ||
                matrix.row(row)!.suffix(matrix.columns - column - 1).max()! < height ||
                matrix.column(column)!.suffix(matrix.rows - row - 1).max()! < height {
                count += 1
            }
        }}
        return count
    }
    
    static func scenicScore(in matrix: Matrix<Int>, _ column: Int, _ row: Int) -> Int {
        let height = matrix[column, row]

        var e = 0
        for h in matrix.row(row)!.suffix(matrix.columns - column - 1) {
            e += 1
            if h >= height { break }
        }
        var w = 0
        for h in matrix.row(row)!.prefix(column).reversed() {
            w += 1
            if h >= height { break }
        }
        var n = 0
        for h in matrix.column(column)!.prefix(row).reversed() {
            n += 1
            if h >= height { break }
        }
        var s = 0
        for h in matrix.column(column)!.suffix(matrix.rows - row - 1) {
            s += 1
            if h >= height { break }
        }
        return e * w * n * s
    }

    static func maxScenicScore(in matrix: Matrix<Int>) -> Int {
        var max = 0
        for row in 0..<matrix.rows {
            for column in 0..<matrix.columns {
                let score = scenicScore(in: matrix, column, row)
                if score > max {
                    max = score
                }
            }
        }
        return max
    }
}

extension Matrix where T == Int {
    static func load(_ strings: [String]) -> Matrix {
        guard strings.count > 0 else { return Matrix(repeating: 0) }
        
        let s = strings.joined().compactMap { Int(String($0), radix: 10) }
        return Matrix<Int>(rows: strings.count, columns: strings[0].count, sequence: s)
    }
}
