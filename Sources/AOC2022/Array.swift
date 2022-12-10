//
//  Array.swift
//  Created by David Lindecrantz on 2022-12-07.
//

extension Array {
    func at(_ index: Int) -> Element? {
        index < self.count ? self[index] : nil
    }
}

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element {
        self.reduce(into: Self.Element.zero ) { $0 += $1 }
    }
}
