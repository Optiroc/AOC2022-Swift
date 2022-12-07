//
//  ElfFS.swift
//  Created by David Lindecrantz on 2022-12-07.
//

class ElfFS {
    enum NodeType {
        case directory
        case file
    }

    class Node {
        let name: String
        let type: NodeType
        let size: Int
        var children: [Node] = []

        var rnodes: [Node] {
            var nodes = [self]
            for child in children { nodes.append(contentsOf: child.rnodes) }
            return nodes
        }

        var rsize: Int {
            rnodes.reduce(into: 0) { $0 += $1.size }
        }

        init(name: String, type: NodeType, size: Int = 0, children: [Node] = []) {
            self.name = name; self.type = type; self.size = size; self.children = children
        }

        func add(_ node: Node) {
            children.append(node)
        }

        func parent(in scope: Node) -> Node? {
            parent(of: self, in: scope)
        }

        private func parent(of node: Node, in scope: Node) -> Node? {
            for child in scope.children {
                if child === node { return scope }
                if let r = parent(of: node, in: child) { return r }
            }
            return nil
        }
   }

    private(set) var root: Node

    init() {
        self.root = Node(name: "/", type: .directory)
    }

    private func cd(_ name: String, from: Node) -> Node {
        switch name {
        case "/":
            return root
        case "..":
            if let parent = from.parent(in: root) {
                return parent
            } else {
                fatalError("Parent of node \(from) not found")
            }
        default:
            if let child = from.children.first(where: { $0.name == name }) {
                return child
            } else {
                fatalError("Child node \(name) not found on node \(from)")
            }
        }
    }

    func populate(from log: [String]) -> Self {
        var wd = root
        for item in log {
            if item.isEmpty || item == "$ ls" {
                continue
            } else if item.starts(with: "$ cd "), let name = item.split(separator: "$ cd ").first {
                wd = cd(String(name), from: wd)
            } else if item.starts(with: "dir"), let name = item.split(separator: "dir ").first {
                wd.add(Node(name: String(name), type: .directory))
            } else {
                let split = item.split(separator: " ", maxSplits: 2)
                if split.count == 2, let size = Int(split[0]), let name = split.last {
                    wd.add(Node(name: String(name), type: .file, size: size))
                }
            }
        }
        return self
    }
}
