//
//  Int.swift
//  Created by David Lindecrantz on 2022-12-09.
//

enum IntegerSign {
    case plus, minus
}

extension SignedInteger {
    var sign: IntegerSign {
        self < 0 ? .minus : .plus
    }
}
