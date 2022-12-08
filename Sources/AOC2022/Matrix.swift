//
//  Matrix.swift
//  Created by David Lindecrantz on 2022-12-08.
//

struct Matrix<T> {
    let rows: Int
    let columns: Int
    private let count: Int
    private var storage: ContiguousArray<T>

    init(rows: Int = 0, columns: Int = 0, repeating: T) {
        self.rows = rows
        self.columns = columns
        self.count = rows * columns
        storage = ContiguousArray(repeating: repeating, count: rows * columns)
    }

    init<S: Sequence>(rows: Int, columns: Int, sequence: S) where S.Element == T {
        self.rows = rows
        self.columns = columns
        self.count = rows * columns
        storage = ContiguousArray(sequence)
        precondition(storage.count == count, "Initialized Matrix<T> with dimensions not matching element count")
    }

    subscript(column: Int, row: Int) -> T {
        get {
            storage[columns * row + column]
        }
        set {
            storage[columns * row + column] = newValue
        }
    }

    func at(row: Int, column: Int) -> T? {
        let index = columns * row + column
        if index >= 0, index < count {
            return storage[index]
        } else {
            return nil
        }
    }
}

// MARK: - Row iterator
extension Matrix {
    func row(_ row: Int) -> Row<T>? {
        Row(matrix: self, index: row)
    }

    struct Row<T>: Sequence, IteratorProtocol, LazySequenceProtocol {
        private var matrix: Matrix<T>
        private let row: Int
        private var index: Int
        private var iterations: Int

        init?(matrix: Matrix<T>, index: Int) {
            guard index >= 0, index < matrix.rows else { return nil }
            self.matrix = matrix
            self.row = index
            self.index = matrix.columns * index
            self.iterations = matrix.columns
        }

        mutating func next() -> T? {
            guard iterations > 0 else { return nil }
            defer {
                index += 1
                iterations -= 1
            }
            return matrix.storage[index]
        }
        
        subscript(column: Int) -> T {
            get {
                matrix.storage[matrix.columns * row + column]
            }
            set {
                matrix.storage[matrix.columns * row + column] = newValue
            }
        }
    }
}

// MARK: - Column iterator
extension Matrix {
    func column(_ column: Int) -> Column<T>? {
        Column(matrix: self, index: column)
    }

    struct Column<T>: Sequence, IteratorProtocol, LazySequenceProtocol {
        private var matrix: Matrix<T>
        private let column: Int
        private var index: Int
        private var iterations: Int

        init?(matrix: Matrix<T>, index: Int) {
            guard index >= 0, index < matrix.columns else { return nil }
            self.matrix = matrix
            self.column = index
            self.index = index
            self.iterations = matrix.rows
        }

        mutating func next() -> T? {
            guard iterations > 0 else { return nil }
            defer {
                index += matrix.columns
                iterations -= 1
            }
            return matrix.storage[index]
        }
        
        subscript(row: Int) -> T {
            get {
                matrix.storage[matrix.columns * row + column]
            }
            set {
                matrix.storage[matrix.columns * row + column] = newValue
            }
        }
    }
}
