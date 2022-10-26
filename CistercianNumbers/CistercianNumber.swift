//
//  CistercianNumber.swift
//  CistercianNumbers
//
//  Created by nutterfi on 10/25/22.
//

import SwiftUI

struct CistercianNumber: Shape, ExpressibleByIntegerLiteral {
  typealias IntegerLiteralType = Int
  
  init(integerLiteral: Self.IntegerLiteralType) {
    self.init(number: integerLiteral)
  }
  
  var number: Int {
    Int(numberAsDouble)
  }
  
  static var role: ShapeRole {
    .stroke
  }
  
  private var numberAsDouble: Double
  
  init(number: Int) {
    numberAsDouble = Double(number)
  }
  
  func path(from value: Int, in rect: CGRect) -> Path {
    switch value {
    case 1:
      return one(in: rect)
    case 2:
      return two(in: rect)
    case 3:
      return three(in: rect)
    case 4:
      return four(in: rect)
    case 5:
      return five(in: rect)
    case 6:
      return six(in: rect)
    case 7:
      return seven(in: rect)
    case 8:
      return eight(in: rect)
    case 9:
      return nine(in: rect)
    default:
      return Path()
    }
  }
  
  func paths(in rect: CGRect) -> [Path] {
    
    let ones = number % 10
    let tens = number % 100 / 10
    let hundreds = number % 1000 / 100
    let thousands = number % 10000 / 1000
    
    let onesRect: CGRect = CGRect(
      origin: .init(x: rect.midX, y: rect.minY),
      size: .init(width: rect.width * 0.25, height: rect.height * 0.25)
    )
    
    let tensRect = onesRect.offsetBy(dx: -0.25 * rect.width, dy: 0)
    let hundredsRect = onesRect.offsetBy(dx: 0, dy: 0.75 * rect.height)
    let thousandsRect = onesRect.offsetBy(dx: -0.25 * rect.width, dy: 0.75 * rect.height)
    
    var paths = [Path]()
    
    paths.append(path(from: ones, in: onesRect))
    paths.append(path(from: tens, in: tensRect).scale(x: -1).path(in: tensRect))
    paths.append(path(from: hundreds, in: hundredsRect).scale(x: 1, y: -1).path(in: hundredsRect))
    paths.append(path(from: thousands, in: thousandsRect).scale(x: -1, y: -1).path(in: thousandsRect))
    
    return paths
  }
  
  func path(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.midX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
      
      let paths = paths(in: rect)
      paths.forEach { subPath in
        path.addPath(subPath)
      }
      
      path = path.strokedPath(
        StrokeStyle(lineCap: .square, lineJoin: .miter, miterLimit: 50)
      )
    }
  }
  
  func one(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.minX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
    }
  }
  
  func two(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    }
  }
  
  func three(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.minX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    }
  }
  
  func four(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
    }
  }
  
  func five(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.minX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    }
  }
  
  func six(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    }
  }
  
  func seven(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.minX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    }
  }
  
  func eight(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
    }
  }
  
  func nine(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: rect.minX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
      path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
    }
  }
  
}

extension CistercianNumber: Animatable {
  var animatableData: Double {
    get {
      numberAsDouble
    }
    
    set {
      numberAsDouble = newValue
    }
  }
}

struct CistercianNumber_Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      let numbers: [CistercianNumber] = [1, 20, 300, 4000, 5555, 6789, 9394]
      ForEach(0..<numbers.count, id:\.self) { index in
        numbers[index]
      }
    }
    .frame(height: 64)
    .border(Color.orange, width: 0.5)
    
  }
}
