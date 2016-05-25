import UIKit

////////////////////////////////////////
// ARC automatic reference counting
////////////////////////////////////////
class Food {
  let name: String
  
  init(name: String) {
    self.name = name
    print("memory allocated for \(name)")
  }
  
  deinit {
    print("\(name) is being deallocated")
  }
}

var f1: Food? = Food(name: "carrot")
var f2: Food? = f1
f1 = nil
// reference is still alive in f2
f2!.name
f2 = nil
// f2!.name error



////////////////////////////////////////
// memory leaks (reference cycle)
////////////////////////////////////////
class Person {
  var name: String
  var apartment: Apartment?
  
  init(name: String) {
    self.name = name
  }
  
  deinit {
    print("person \(name) deallocated")
  }
}

class Apartment {
  let unit: String
  // TODO: fixed by making this weak var
  var tenant: Person?
  
  init(unit: String) {
    self.unit = unit
  }

  deinit {
    print("apartment \(unit) deallocated")
  }
}


var p1: Person? = Person(name: "bob")
var a1: Apartment? = Apartment(unit: "38")

// reference cycle
p1?.apartment = a1
a1?.tenant = p1

// neither are dealloced even though both are nil
p1 = nil
a1 = nil
