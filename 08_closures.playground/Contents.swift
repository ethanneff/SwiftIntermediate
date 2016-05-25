// closures
// 16.05.17



/////////////////////////////////////////
// functions
/////////////////////////////////////////
func printString(aString: String) {
  print("Hello \(aString)")
}
printString("rawr")



/////////////////////////////////////////
// functions as a constant
/////////////////////////////////////////
let someFunction = printString
someFunction("rawr again")
let anotherFunction: String -> Void = printString
anotherFunction("rawr again")



/////////////////////////////////////////
// functions as a parameter
/////////////////////////////////////////
func displayString(a: String -> Void) {
  a("I'm a function inside a function")
}
displayString(printString)



/////////////////////////////////////////
// extension Int type
/////////////////////////////////////////
extension Int {
  func apply(operation: Int -> Int) -> Int {
    return operation(self) // pass self (int) to the operation function
  }
}
func double(value: Int) -> Int {
  return 2*value
}
func closestMultipleofSix(value: Int) -> Int {
  for x in 1...100 {
    let multiple = x * 6
    if multiple - value < 6 && multiple > value {
      return multiple
    } else if multiple == value {
      return value
    }
  }
  return 0
}
10.apply(double)
12.apply(closestMultipleofSix)



/////////////////////////////////////////
// returning functions
/////////////////////////////////////////
typealias IntegerFunction = Int -> Void
func gameCounter() -> IntegerFunction {
  var counter = 0 // caputured variable (maintains state)
  func increment(i: Int) {
    counter += i
    print("counter value: \(counter)")
  }
  return increment
}
let aCounter = gameCounter() // assign to function (creates and instance of the function)
aCounter(1)
let bCounter = gameCounter   // assign to name (doesn't work)
bCounter()


/////////////////////////////////////////
// capturing variables
/////////////////////////////////////////
aCounter(1)
aCounter(1)
aCounter(4)



/////////////////////////////////////////
// closure expression
/////////////////////////////////////////
func doubler(i: Int) -> Int {
  return i * 2
}
let doubleFunc = doubler
doubleFunc(2)

let doubleNumbers = [1,2,3].map(doubleFunc)
let closureExps = [1,2,3].map( { (i: Int) -> Int in return i*3 } )



/////////////////////////////////////////
// closure expression shorthand syntax
/////////////////////////////////////////
let inferredType = [1,2,3].map( { i in return i*3 } )
let implicitType = [1,2,3].map( { i in i*3 } )
let shorthandArgs = [1,2,3].map( { $0*3 } )
let trailingClosure = [1,2,3].map() { $0*3 }
let ignoreParentheses = [1,2,3].map { $0*3 }
