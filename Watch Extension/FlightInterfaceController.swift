//
//  FlightInterfaceController.swift
//  AirAber
//
//  Created by Robert Martin on 11/21/16.
//

import WatchKit
import Foundation


class FlightInterfaceController: WKInterfaceController {

  @IBOutlet var flightLabel: WKInterfaceLabel!
  @IBOutlet var routeLabel: WKInterfaceLabel!
  @IBOutlet var boardingLabel: WKInterfaceLabel!
  @IBOutlet var boardTimeLabel: WKInterfaceLabel!
  @IBOutlet var statusLabel: WKInterfaceLabel!
  @IBOutlet var gateLabel: WKInterfaceLabel!
  @IBOutlet var seatLabel: WKInterfaceLabel!
  
  // declared an optional property of type Flight. This class is declared in Flight.swift, which is part of the shared code added to the Watch Extension target earlier
  var flight: Flight? {
    
    //  add a property observer that is triggered whenever the property is set
    didSet {
      
      // checking  there’s an actual flight rather than nil in the optional property. You only want to proceed with configuring the labels when you know you have a valid instance of Flight
      guard let flight = flight else { return }
      
      // configuring the labels using the relevant properties of flight
      flightLabel.setText("Flight \(flight.shortNumber)")
      routeLabel.setText(flight.route)
      boardingLabel.setText("\(flight.number) Boards")
      boardTimeLabel.setText(flight.boardsAt)
      
      // If flight is delayed, change the text color of the label to red
      if flight.onSchedule {
        statusLabel.setText("On Time")
      } else {
        statusLabel.setText("Delayed")
        statusLabel.setTextColor(.red)
      }
      gateLabel.setText("Gate \(flight.gate)")
      seatLabel.setText("Seat \(flight.seat)")
    }
  }
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    //try to cast context to an instance of Flight. If it succeeds, you use it to set self.flight, which will in turn trigger the property observer, and configure the interface
    if let flight = context as? Flight {
      self.flight = flight
    }
  }

  

}
