import Foundation

func part1() {
  let input = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
  let pattern = #"mul\((\d{1,3}),(\d{1,3})\)"#
  
  let regex = try! NSRegularExpression(pattern: pattern)
  
  let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))
  
  var aggregator = 0
  
  for match in matches {
    if let range1 = Range(match.range(at: 1), in: input), let range2 = Range(match.range(at: 2), in: input) {
      let number1 = input[range1]
      let number2 = input[range2]
      aggregator += Int(number1)! * Int(number2)!
    }
  }

  print(#function, aggregator)
}

func part2() {
  let input = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
  let pattern = #"mul\((\d{1,3}),(\d{1,3})\)|(do\(\))|(don't\(\))"#

  let regex = try! NSRegularExpression(pattern: pattern)
  let matches = regex.matches(in: input, range: NSRange(input.startIndex..., in: input))

  var isEnabled = true
  var aggregator = 0

  for match in matches {
    if let instructionRange = Range(match.range(at: 0), in: input) {
      let instruction = input[instructionRange]
      switch instruction {
        case "do()":
          isEnabled = true
        case "don't()":
          isEnabled = false
        default:
          if isEnabled {
            if
              let range1 = Range(match.range(at: 1), in: input),
              let range2 = Range(match.range(at: 2), in: input)
            {
              let number1 = input[range1]
              let number2 = input[range2]
              aggregator += Int(number1)! * Int(number2)!
            }
          }
      }
    }
  }

  print(#function, aggregator)
}

part1()
part2()
