// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

if let path = Bundle.module.path(forResource: "data", ofType: "txt") {
  do {
    var firstColumn: [Int] = []
    var secondColumn: [Int] = []

    let data = try String(contentsOfFile: path, encoding: .utf8)
    data.components(separatedBy: .newlines).forEach { line in
      let items = line.split(separator: " ").compactMap { Int($0) }
      guard !items.isEmpty else { return }

      firstColumn.append(items[0])
      secondColumn.append(items[1])
    }

    var part1Counter = 0

    for (i, j) in zip(firstColumn.sorted(), secondColumn.sorted()) {
      part1Counter += abs(i - j)
    }

    var part2Counter = 0

    for i in firstColumn {
      part2Counter += i * secondColumn.count(where: { $0 == i })
    }

    print("part 1 - \(part1Counter)")
    print("part 2 - \(part2Counter)")
  } catch { print(error) }
}

