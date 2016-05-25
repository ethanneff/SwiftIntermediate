import UIKit


////////////////////////////////////////
// instance (stored) property
////////////////////////////////////////
struct Account {
  let username: String
  let password: String
}

let someAccount = Account(username: "instanceBob", password: "simplePasssword")



////////////////////////////////////////
// type property
////////////////////////////////////////
struct Point {
  let x: Int
  let y: Int
}

struct Map {
  static let origin: Point = Point(x: 0, y: 0)
}

Map.origin



////////////////////////////////////////
// computed property
////////////////////////////////////////
struct Rectangle {
  var length: Int
  var width: Int
  
  var area: Int {
    return length * width
  }
}

let r1 = Rectangle(length: 50, width: 10)
r1.area



////////////////////////////////////////
// getters and setters
////////////////////////////////////////
struct Point1 {
  var x: Int = 0
  var y: Int = 0
}

struct Size1 {
  var width: Int = 0
  var height: Int = 0
}


struct Rectangle1 {
  var origin = Point1()
  var size = Size1()
  var center: Point1 {
    get {
      let centerX = origin.x + size.width/2
      let centerY = origin.y + size.height/2
      return Point1(x: centerX, y: centerY)
    }
    set(centerValue) {
      origin.x = centerValue.x - size.width/2
      origin.y = centerValue.y - size.height/2
    }
  }
}

var r2 = Rectangle1()
print(r2.center) // 0,0
r2.center = Point1(x: 10, y: 14)
print(r2.center) // 10,14



////////////////////////////////////////
// computed property example
////////////////////////////////////////
enum ReadingMode {
  case Day
  case Evening
  case Night
  
  var statusBarStyle: UIStatusBarStyle {
    switch self {
    case .Day, .Evening: return .Default
    case .Night: return .LightContent
    }
  }
  
  var headlineColor: UIColor {
    switch self {
    case Night: return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    case .Evening, .Day: return UIColor(red: 16/255.0, green: 16/255.0, blue: 16/255.0, alpha: 1.0)
    }
  }
  
  var dateColor: UIColor {
    switch self {
    case .Day, .Evening: return UIColor(red: 132/255.0, green: 132/255.0, blue: 132/255.0, alpha: 1.0)
    case .Night: return UIColor(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1.0)
    }
  }
  
  var bodyTextColor: UIColor {
    switch self {
    case .Day, .Evening: return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    case .Night: return UIColor(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: 1.0)
    }
  }
  
  var linkColor: UIColor {
    switch self {
    case .Day, .Evening: return UIColor(red: 68/255.0, green: 133/255.0, blue: 164/255.0, alpha: 1.0)
    case .Night: return UIColor(red: 129/255.0, green: 161/255.0, blue: 166/255.0, alpha: 1.0)
    }
  }
}


let titleLabel = UILabel()

func readingViewWithMode(readingMode: ReadingMode) {
  titleLabel.textColor = readingMode.headlineColor
}


////////////////////////////////////////
// lazy stored properties
////////////////////////////////////////
class ReadItLaterClient {
  lazy var session: NSURLSession = NSURLSession(configuration: .defaultSessionConfiguration())
}


////////////////////////////////////////
// property observers
////////////////////////////////////////
struct Car {
  var make: String
  var model: String
  var color: UIColor {
    willSet {
      print("notify wife")
    }
    didSet {
      print("notify friends")
    }
  }
}
