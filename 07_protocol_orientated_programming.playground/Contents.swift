//
//  ControlTower.swift
//  AirplaneControlTower
//
//  Created by Ethan Neff on 4/21/16.
//  Copyright © 2016 Ethan Neff. All rights reserved.
//

import Foundation

typealias Knots = Int

// MARK: protocols
protocol Flying {
  var descentSpeed: Knots { get }
}

protocol Landing {
  func requestLandingInstructions() -> LandingInstructions
}

protocol Airline: Flying, Landing {
  var type: AirlineType { get }
}

// default implimatation to protocol
extension Airline {
  var descentSpeed: Knots {
    return type.descentSpeed
  }
  
  func requestLandingInstructions() -> LandingInstructions {
    return ControlTower().land(self)
  }
}

// marker protocol to reference multiple enums
protocol AirlineType: Flying {
  
}

struct LandingInstructions {
  let runway: ControlTower.Runway
  let terminal: ControlTower.Terminal
}

// MARK: flight
struct Flight: Airline {
  let type: AirlineType
}

// MARK: airline types
enum DomesticAirlineType: AirlineType {
  case Delta
  case American
  case United
}

extension DomesticAirlineType {
  var descentSpeed: Knots {
    return 100
  }
}

enum InternationalAirlineType: AirlineType {
  case Lufthansa
  case KLM
  case AirFrance
}

extension InternationalAirlineType {
  var descentSpeed: Knots {
    return 130
  }
}

// MARK: control tower
final class ControlTower { // no override
  
  // functions
  func land(airline: Airline) -> LandingInstructions {
    let runway = Runway.runway(airline.descentSpeed)
    let terminal = Terminal.terminal(airline)
    return LandingInstructions(runway: runway, terminal: terminal)
  }
  
  // different runways
  enum Runway {
    case R22L
    case L31R
    case M52J
    case B19E
    
    // determine runway based on speed
    static func runway(speed: Knots) -> Runway {
      switch speed {
      case 0..<91: return .R22L
      case 91..<120: return .L31R
      case 120..<140: return .M52J
      case 141..<165: return .B19E
      default: return .B19E
      }
    }
  }
  
  // different terminals (nil gate if none available)
  enum Terminal {
    case A(Int?)
    case B(Int?)
    case C(Int?)
    case International(Int?)
    case Private(Int?)
    
    static func terminal(airline: Airline) -> Terminal {
      switch airline.type {
      case is DomesticAirlineType:
        let domesticAirline = airline.type as! DomesticAirlineType
        switch domesticAirline {
        case .Delta:
          let gate = GateManager.sharedInstance.gateFor(.A(nil))
          return .A(gate)
        case .American:
          let gate = GateManager.sharedInstance.gateFor(.B(nil))
          return .B(gate)
        case .United:
          let gate = GateManager.sharedInstance.gateFor(.C(nil))
          return .C(gate)
        }
      case is InternationalAirlineType:
        let gate = GateManager.sharedInstance.gateFor(.International(nil))
        return .International(gate)
      default:
        let gate = GateManager.sharedInstance.gateFor(.Private(nil))
        return .Private(gate)
      }
    }
  }
  
  class GateManager {
    // singleton for any ControlTower
    static let sharedInstance = GateManager()
    private init() {}
    
    // properties
    private var gatesForTerminalA: [String: [Int]] = ["occupied": [1,2,3,4,5,6,7,8], "empty": [9,10,11,12]]
    private var gatesForTerminalB: [String: [Int]] = ["occupied": [1], "empty": [2,3,4,5,6,7,8]]
    private var gatesForTerminalC: [String: [Int]] = ["occupied": [1,2,3,4], "empty": [5,6,7,8,9,10]]
    private var gatesForInternationalTerminal: [String: [Int]] = ["occupied": [1,2,3], "empty": [4,5,6]]
    private var gatesForPrivateHangars: [String: [Int]] = ["occupied": [1], "empty": [2,3]]
    
    // public
    func gateFor(terminal: Terminal) -> Int? {
      switch terminal {
      case .A: return emptyGate(&gatesForTerminalA)
      case .B: return emptyGate(&gatesForTerminalB)
      case .C: return emptyGate(&gatesForTerminalC)
      case .International: return emptyGate(&gatesForInternationalTerminal)
      case .Private: return emptyGate(&gatesForPrivateHangars)
      }
    }
    
    // helper
    private func update(inout gates: [String: [Int]], gate: Int) {
      if var occupiedGates = gates["occupied"] {
        occupiedGates.append(gate)
        gates.updateValue(occupiedGates, forKey: "occupied")
      }
      
      if var emptyGates = gates["empty"], let index = emptyGates.indexOf(gate) {
        emptyGates.removeAtIndex(index)
        gates.updateValue(emptyGates, forKey: "empty")
      }
    }
    
    private func emptyGate(inout gates: [String: [Int]]) -> Int? {
      guard let gate = gates["empty"]?.first else {
        return nil
      }
      update(&gates, gate: gate)
      return gate
    }
  }
}


// new airline
let domesticFlight = Flight(type: DomesticAirlineType.United)
// get instructions
print(domesticFlight.requestLandingInstructions())

let domesticFlight2 = Flight(type: DomesticAirlineType.United)
print(domesticFlight2.requestLandingInstructions())

let internationalFlight = Flight(type: InternationalAirlineType.AirFrance)
print(internationalFlight.requestLandingInstructions())