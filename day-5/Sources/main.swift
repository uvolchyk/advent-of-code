// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

extension Array {
  var middle: Element {
    let middleIndex = count / 2
    return self[middleIndex]
  }
}

if
  let rulesPath = Bundle.module.path(forResource: "rules", ofType: nil),
  let updatesPath = Bundle.module.path(forResource: "updates", ofType: nil)
{
  do {
    let rulesData = try String(contentsOfFile: rulesPath, encoding: .utf8)
    let updatesData = try String(contentsOfFile: updatesPath, encoding: .utf8)
    let updatesLines = updatesData
      .components(separatedBy: .newlines)
      .filter { !$0.isEmpty }
      .map {
        $0.split(separator: ",").compactMap { Int($0) }
      }

    var easyValidAccumulator = 0
    var hardValidAccumulator = 0
    var rules: [Int: [Int]] = [:]

    rulesData
      .components(separatedBy: .newlines)
      .filter { !$0.isEmpty }
      .forEach { rule in
        let _rule = rule.split(separator: "|").map { Int($0) }
        let key = _rule[0]!
        let value = _rule[1]!

        
        if rules[key] == nil {
          rules[key] = []
        }
        rules[key]?.append(value)
      }

    updatesLines.forEach { updates in
      var isValid = true
      for i in 0..<updates.count {
        let ruleValues = rules[updates[i], default: []]
        for j in (i + 1)..<updates.count {
          if !ruleValues.contains(updates[j]) {
            isValid = false
            break
          }
        }
      }

      if isValid {
        easyValidAccumulator += updates.middle
      } else {
        var newRules = [Int: Set<Int>]()
        for i in updates {
          newRules[i] = Set(rules[i, default: []]).intersection(Set(updates))
        }

        // sort by the number of possible values within the update row
        // less rules - more likely it's the one that should be placed near the end
        // more rules - more likely it's the one that should be placed near the start
        let update = newRules.sorted(by: { $0.value.count > $1.value.count }).map { $0.key }
        hardValidAccumulator += update.middle
      }
    }
    
    print("part 1 - \(easyValidAccumulator)")
    print("part 2 - \(hardValidAccumulator)")
  } catch { print(error) }
}
