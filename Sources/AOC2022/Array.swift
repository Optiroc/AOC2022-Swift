//
//  Array.swift
//  Created by David Lindecrantz on 2022-12-07.
//

extension Array {
    func at(_ index: Int) -> Element? {
        index < self.count ? self[index] : nil
    }
}
