import UIKit


////////////////////////////////////////
// value semantics
////////////////////////////////////////
struct Point {
  var x: Double
  var y: Double
  
  // change value types with mutating
  mutating func moveLeft(steps: Double) {
    x -= steps
  }
}

var p1 = Point(x: 1, y: 2)
var p2 = p1

p1.x = 4
p2.x // 1


// cannot change if let
let p3 = Point(x: 2, y: 4)



////////////////////////////////////////
// reference semantics
////////////////////////////////////////
class Robot {
  var model: String
  
  init(model: String) {
    self.model = model
  }
}

var r1 = Robot(model: "T291")
var r2 = r1
r1.model = "R999"
r2.model // "R999"

// can change even if let
let r3 = Robot(model: "R222")
r3.model = "TXXX"
r3.model



////////////////////////////////////////
// mixed semantics
////////////////////////////////////////
struct Shape {
  let shapeView: UIView
  
  init(width:CGFloat, height: CGFloat, color:UIColor) {
    let frame = CGRect(x: 0, y: 0, width: width, height: height)
    shapeView = UIView(frame: frame)
    shapeView.backgroundColor = color
  }
}

// able to change shapeView b/c shapeView is a reference type
// eventhough it is stored within a value type Shape
let s1 = Shape(width: 100, height: 100, color: .redColor())
s1.shapeView.backgroundColor = .blueColor()



////////////////////////////////////////
// type method
////////////////////////////////////////
struct Map {
  static let origin: Point = Point(x: 0, y: 0)
  
  static func distanceFromOrigin(point: Point) -> Double {
    let h = origin.x - point.x
    let v = origin.y - point.y
    
    func square(value: Double) -> Double {
      return value * value
    }
    
    return sqrt(square(h) + square(v))
  }
}



////////////////////////////////////////
// final classes
////////////////////////////////////////
class Calculator {
  class func squareRoot(value: Double) -> Double {
    return sqrt(value)
  }
  class final func square(value: Double) -> Double {
    return value*value
  }
}


class NewtonCalculator: Calculator {
  override class func squareRoot(value: Double) -> Double {
    var guess = 1.0
    var newGuess: Double
    while true {
      newGuess = (value/guess + guess)/2
      if guess == newGuess {
        return guess
      }
      guess = newGuess
    }
  }
}

Calculator.square(2)
