//
//  SupplyStacks.swift
//  Created by David Lindecrantz on 2022-12-07.
//

import Collections

class SupplyStacks<T> {
    private var stacks: [Deque<T>]

    init(stacks: Int) {
        self.stacks = Array(repeating: Deque<T>(), count: stacks)
    }

    func insert(element: T, into stack: Int) {
        stacks[stack].append(element)
    }

    func move(from: Int, to: Int) {
        if let item = stacks[from].popFirst() {
            stacks[to].prepend(item)
        }
    }

    func move(amount: Int, from: Int, to: Int) {
        for _ in 0..<amount {
            move(from: from, to: to)
        }
    }

    func move9001(amount: Int, from: Int, to: Int) {
        let batch = stacks[from][0..<amount]
        stacks[to].prepend(contentsOf: batch)
        for _ in 0..<amount {
            _ = stacks[from].popFirst()
        }
    }
}

extension SupplyStacks<Character> {
    var word: String {
        stacks.reduce(into: "") { $0.append($1.first != nil ? $1.first! : Character("")) }
    }
}
