//
//  ElfCPU.swift
//  Created by David Lindecrantz on 2022-12-10.
//

class ElfCPU {
    enum Instruction {
        case noop
        case addx(Int)

        var cycles: Int {
            switch self {
            case .noop: return 1
            case .addx: return 2
            }
        }

        static func from(_ str: String) -> Self {
            let a = str.split(separator: " ")
            switch a.count {
            case 1 where a[0] == "noop":
                return .noop
            case 2 where a[0] == "addx":
                if let v = Int(a[1]) { return .addx(v) } else { fatalError("Unknown parameter for addx") }
            default: fatalError("Unknown instruction: \(str)")
            }
        }
    }

    var program: [Instruction]
    var x: Int = 1
    var pc: Int = 0
    var tick: Int = 0

    var currentOp: Instruction = .noop
    var currentOpTick: Int = 0

    var lineBuffer = ContiguousArray(repeating: false, count: 40)
    var frameBuffer = [String]()

    var signalStrength: Int { tick * x }

    init(program: [Instruction]) {
        self.program = program
    }

    convenience init(program: [String]) {
        self.init(program: program.map { Instruction.from($0) })
    }

    func run() -> Bool {
        if currentOpTick == 0 {
            switch currentOp {
            case .noop: break
            case .addx(let v): x += v
            }
            if pc >= program.count { return true }
            currentOp = program[pc]
            currentOpTick = currentOp.cycles
            pc += 1
        }

        draw()
        currentOpTick -= 1
        tick += 1
        return false
    }

    private func draw() {
        let pos = tick % 40
        lineBuffer[pos] = (pos - 1...pos + 1).contains(x) ? true : false
        if pos == 39 {
            frameBuffer.append(lineBuffer.reduce(into: "") { $0 += $1 ? "#" : "." })
        }
    }

    func run(ticks: Int = 1, debugLog: Bool = false) {
        precondition(ticks >= 1)
        for _ in 1...ticks {
            _ = run()
            if debugLog { print(self) }
        }
    }

    func run(ticks: [Int], debugLog: Bool = false) -> [Int] {
        ticks.map {
            run(ticks: $0 - tick, debugLog: debugLog)
            return signalStrength
        }
    }

    func runUntilEOP(debugLog: Bool = false) {
        while true {
            if run() { break }
            if debugLog { print(self) }
        }
    }
}

extension ElfCPU: CustomDebugStringConvertible {
    var debugDescription: String {
        "T:\(tick) PC:\(pc) I:\(currentOp) X:\(x) S:\(signalStrength)"
    }
}
