import UIKit


////////////////////////////////////////
// failable init
////////////////////////////////////////
class Person {
  let name: String
  let age: Int
  
  init?(dict: [String: AnyObject]) {
    guard let name = dict["name"] as? String, let age = dict["age"] as? Int else {
      return nil
    }
    
    self.name = name
    self.age = age
  }
}


////////////////////////////////////////
// throwable init
////////////////////////////////////////
class Dog {
  let name: String
  let age: Int
  
  init(dict: [String: AnyObject]) throws {
    guard let name = dict["name"] as? String, let age = dict["age"] as? Int else {
      throw DogError.InvalidData
    }
    
    self.name = name
    self.age = age
  }
}

enum DogError: ErrorType {
  case InvalidData
}




////////////////////////////////////////
// Initializer Delegation
////////////////////////////////////////
struct Point {
  var x: Int = 0
  var y: Int = 0
}

struct Size {
  var width: Int = 0
  var height: Int = 0
}


struct Rectangle1 {
  var origin = Point()
  var size = Size()

  init(origin: Point, size: Size) {
    self.origin = origin
    self.size = size
  }
  
  // delegate
  init(x: Int, y: Int, height: Int, width: Int) {
    let origin = Point(x: x, y: y)
    let size = Size(width: width, height: height)
    
    self.init(origin: origin, size: size)
  }
}



////////////////////////////////////////
// Designated Initializers
////////////////////////////////////////
class Vehicle {
  var name: String
  
  // designated
  init(name: String) {
    self.name = name
  }
  
  // convenience
  convenience init() {
    self.init(name: "unanmed")
  }
}


////////////////////////////////////////
// Initializing Superclasses
////////////////////////////////////////
class Airplane: Vehicle {
  let seats: Int
  
  init(name: String, seats: Int) {
    self.seats = seats
    super.init(name: name)
  }
  
  // overrides parent init()
  convenience override init(name: String) {
    self.init(name: name, seats: 4)
  }
  
  // calls the other convenience init (override) so doesnt need seats
  convenience init() {
    self.init(name: "unnamed")
  }
}



////////////////////////////////////////
// Required Initializers
////////////////////////////////////////
class AnotherClass: UIViewController {
  let someString: String
  
  init(someString: String) {
    self.someString = someString
    super.init(nibName:nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    // need to default to something to save to NSCoder
    self.someString = ""
    super.init(coder: aDecoder)
  }
}
