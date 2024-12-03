// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

if let path = Bundle.module.path(forResource: "data", ofType: "txt") {
  do {
    var safeCounter: Int = 0
    var dumpenerCounter: Int = 0
    let data = try String(contentsOfFile: path, encoding: .utf8)
    data.components(separatedBy: .newlines).forEach { report in
      if report.isEmpty { return }
      let levels = report.components(separatedBy: .whitespaces).compactMap { Int($0) }

      if isReportSafe(levels) {
        safeCounter += 1
      } else if dumpener(levels) {
        dumpenerCounter += 1
      }
    }

    print("part 1 - \(safeCounter)")
    print("part 2 - \(safeCounter + dumpenerCounter)")
  } catch { print(error) }
}

func isReportSafe(_ levels: [Int]) -> Bool {
  var isIncreasing = false
  var isDecreasing = false

  for i in 0..<(levels.count - 1) {
    let diff = levels[i] - levels[i + 1]

    if diff < 0 {
      isIncreasing = true
    } else if diff > 0 {
      isDecreasing = true
    } else {
      return false
    }

    if isIncreasing, isDecreasing { return false }

    if abs(diff) > 3 { return false }
  }

  return true
}

func dumpener(_ levels: [Int]) -> Bool {
  var isSafe = false
  for (i, _) in levels.enumerated() {
    isSafe = isReportSafe(Array(levels[..<i] + levels[(i + 1)...]))
    if isSafe { return true }
  }
  return false
}
