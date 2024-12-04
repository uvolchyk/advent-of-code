// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

extension StringProtocol {
  subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
}

if let path = Bundle.module.path(forResource: "data", ofType: "txt") {
  do {

    var buff = [String]()
    var straightPass: [Int: [Character]] = [:]
    var reversedPass: [Int: [Character]] = [:]

    let data = try String(contentsOfFile: path, encoding: .utf8)
    let rows = data.components(separatedBy: .newlines).filter { !$0.isEmpty }

    _ = {
      // add rows
      buff.append(contentsOf: rows)

      // add columns
      for col in 0..<rows[0].count {
        var colString = ""
        for row in 0..<rows.count {
          colString += String(rows[row][col])
        }
        buff.append(colString)
      }

      // add diagonals (both primary and secondary)
      rows.enumerated().forEach { row, line in
        line.enumerated().forEach { col, char in
          if straightPass[row - col] == nil { straightPass[row - col] = [] }
          straightPass[row - col]?.append(char)

          if reversedPass[col + row] == nil { reversedPass[col + row] = [] }
          reversedPass[col + row]?.append(char)
        }
      }

      buff += straightPass.values.map { String($0) }
      buff += reversedPass.values.map { String($0) }

      // brute force search for "XMAS" and "SAMX" in the buffer
      print(
        buff.reduce(0, { partialResult, string in
          partialResult + (string.components(separatedBy: "XMAS").count - 1) + (string.components(separatedBy: "SAMX").count - 1)
        })
      )
    }()

    _ = {
      var masCount = 0
      let msSet = Set([Character("M"), Character("S")])

      // by condition, MAS must build "X" - X-MAS, you know
      // so, once we find "A", we check surrounding diagonals for "M" and "S"
      // all four corners must contain either "M" or "S"
      for r in 1..<(rows.count - 1) {
        for c in 1..<(rows[0].count - 1) {
          if
            rows[r][c] == "A",
            Set([rows[r + 1][c + 1], rows[r - 1][c - 1]]) == msSet,
            Set([rows[r - 1][c + 1], rows[r + 1][c - 1]]) == msSet
          {
            masCount += 1
          }
        }
      }

      print(masCount)
    }()
  } catch { print(error) }
}

