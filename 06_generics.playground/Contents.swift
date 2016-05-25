import UIKit


////////////////////////////////////////
// generic inout
////////////////////////////////////////
func switcheroo <T> (inout a: T, inout b: T) {
  let tempA = a
  a = b
  b = tempA
}

var five = 5.5
var ten = 10.5


switcheroo(&five, b: &ten)
five
ten



////////////////////////////////////////
// generic method (any protocol of type)
////////////////////////////////////////
class GuestCheck {
  
  var roomNo: Int?
  var chargeType: ChargeType?
  var note: String?
  var subtotal = 10.0
  var gratuity = 0.0
  var tax: Double {
    return subtotal * 0.05
  }
  var total: Double {
    return subtotal + gratuity + tax
  }
  
  enum ChargeType {
    
    case Restaurant
    case RoomService
    case SpaServices
    case Entertainment
    case Fitness
  }
}

class RestaurantCheck: GuestCheck {
  
  var foodSubtl = 0.0
  var bevSubtl = 0.0
  var tableNo: Int
  
  init(tableNo: Int) {
    self.tableNo = tableNo
    super.init()
    self.chargeType = .RoomService
  }
  
}

class SpaCheck: GuestCheck {
  
  var therapistID: Int?
  var productsPurchased = []
  var servicesPurchased = []
  
  override init() {
    super.init()
    self.chargeType = .SpaServices
  }
  
  enum SpaServices {
    case massage
    case mudBath
    case manicure
    case pedicure
  }
  
  enum SpaProducts {
    case massage
    case mudBath
    case manicure
    case pedicure
  }
}

// cannot do guestCheck: GuestCheck
// use generics to pass data of the same protocol (able to pass subprotocols)
func guestRetroDiscount<T: GuestCheck> (discount: Double, guestCheck: T, note: String) -> T {
  guestCheck.note = note
  guestCheck.subtotal = guestCheck.subtotal * (1-discount)
  return guestCheck
}

var tmpSpa = SpaCheck()
tmpSpa.subtotal = 25.0
tmpSpa.gratuity = 8.0
tmpSpa.total

tmpSpa = guestRetroDiscount(0.25, guestCheck: tmpSpa, note: "This is a note")
tmpSpa.total
tmpSpa.subtotal




////////////////////////////////////////
// generic type
////////////////////////////////////////
protocol OnlyThisType {
  var name: String { get set }
}

struct Team: OnlyThisType {
  var name: String
  var city: String
  var winPCT: Double = 0.0
  
  
  init(name: String, city: String) {
    self.name = name
    self.city = city
  }
}

struct Player: OnlyThisType {
  var name: String
  var height: Double
  
  init(name: String, height: Double) {
    self.name = name
    self.height = height
  }
}

struct Car {
  var name: String
  var weight: Double
  
  init(name: String, weight: Double) {
    self.name = name
    self.weight = weight
  }
}

// set the generic
class StatGroup<E: OnlyThisType> {
  var title: String
  
  // able to pass generic instead of [Team]
  var members = [E]()
  
  init(title: String, members: [E]) {
    self.title = title
    self.members = members
  }
}

var t1 = Team(name: "blazers", city: "portland")
var t2 = Team(name: "nuggets", city: "denver")

var s1 = StatGroup(title: "nba west", members: [t1,t2])
s1.members

var p1 = Player(name: "rick", height: 88)
var p2 = Player(name: "andrew", height: 66)

var s2 = StatGroup(title: "ice fencing team", members: [p1,p2])

var c1 = Car(name: "civic", weight: 2200)
var c2 = Car(name: "prius", weight: 1800)

// does not work because not of
// var s3 = StatGroup(title: "compact cars", members: [c1,c2])




////////////////////////////////////////
// generic type constraint
////////////////////////////////////////
func getLarger <T: Comparable> (valueA: T, valueB: T) -> T {
  // able to take in Ints and Doubles
  if valueA > valueB {
    return valueA
  }
  else {
    return valueB
  }
}

getLarger(2, valueB: 2.2)



////////////////////////////////////////
// generic associated type
////////////////////////////////////////
import UIKit

protocol Person {
  var name: String {get}
  var hometown: String  {get}
  var height: Double {get}
  
  // associated type
  associatedtype PositionType
  var positions: PositionType {get}
  
}

struct BaseballPlayer: Person {
  var name: String
  var hometown: String
  var height: Double
  // typealias
  typealias PositionType = Array<String>
  var positions: PositionType
  
  init(name: String, height: Double, hometown: String, positions: PositionType) {
    self.name = name
    self.height = height
    self.hometown = hometown
    self.positions = positions
  }
}

struct Coach: Person {
  var name: String
  var hometown: String
  var height: Double
  
  typealias PositionType = String
  var positions: PositionType
  
}

// array position
var newPlayer = BaseballPlayer(name: "Jim", height: 66, hometown: "Boston, MA", positions: ["15", "6", "11"])
// string position
var newCoach = Coach(name: "Billy", hometown: "Newton, MA", height: 76, positions: "Head Coach")

struct Executive {
  var name: String
  var hometown: String
  var height: Double
  
  var positions: String
}

extension Executive: Person {
  
}



////////////////////////////////////////
// generic where clauses
////////////////////////////////////////
func allItemsMatch<P1: Person, P2: Person where P1.PositionType == P2.PositionType>(p1: P1, p2: P2)-> Bool {
  return true
}

allItemsMatch(newCoach, p2: newCoach)
// fails because not of same PositionType
// allItemsMatch(newCoach, p2: newPlayer)



















