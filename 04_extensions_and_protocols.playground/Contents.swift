import UIKit
import GameKit


////////////////////////////////////////
// extension native types
////////////////////////////////////////
extension Int {
  var isOdd : Bool {
    return self % 2 != 0
  }
}

3.isOdd
8.isOdd



////////////////////////////////////////
// extension native types
////////////////////////////////////////
extension String {
  func add(num: Int) -> Int? {
    if let i = Int(self) {
      return i + num
    } else {
      return nil
    }
  }
}

"1".add(2)
"a".add(2)



////////////////////////////////////////
// extension native types with protocol
////////////////////////////////////////
protocol UniqueType {
  var id: Int { get }
}

extension UIView: UniqueType {
  var id: Int {
    get {
      return GKRandomSource.sharedRandom().nextIntWithUpperBound(1000)
    }
  }
}

let u = UIView()
u.id
u.id



////////////////////////////////////////
// extension native types with protocol
////////////////////////////////////////
protocol PrettyPrintable {
  var prettyDescription: String { get }
}

struct User {
  let name: String
  let ID: Int
  
}

extension User: PrettyPrintable {
  var prettyDescription: String {
    return "\(name) \(ID)"
  }
}


////////////////////////////////////////
// extension protocol
////////////////////////////////////////
extension UniqueType {
  var id: Int {
    return GKRandomSource.sharedRandom().nextIntWithUpperBound(1000)
  }
}



////////////////////////////////////////
// method dispatch
////////////////////////////////////////
protocol PersonType {
  var firstName: String { get }
  var middleName: String? { get }
  var lastName: String { get }
  
  func fullName() -> String
}

extension PersonType {
  func fullName() -> String {
    return "\(firstName) \(middleName ?? "") \(lastName)"
  }
  
  func greeting() -> String {
    return "Hi, " + fullName()
  }
}

struct User1: PersonType {
  let firstName: String
  let middleName: String?
  let lastName: String
 
  func greeting() -> String {
    return "Hey there, " + fullName()
  }
  
}


let u1: User1 = User1(firstName: "aiosdna", middleName: nil, lastName: "asodinas")
let u2: PersonType = User1(firstName: "wew", middleName: "wewe", lastName: "asdiona")
u1.greeting()
u2.greeting()
