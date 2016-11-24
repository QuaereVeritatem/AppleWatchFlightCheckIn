//
//  ScheduleInterfaceController.swift
//  AirAber
//
//  Created by Robert Martin on 11/21/16
//

import WatchKit
import Foundation


class ScheduleInterfaceController: WKInterfaceController {

  @IBOutlet var flightsTable: WKInterfaceTable!

  //adding a property that holds all the flight information as an array of Flight instances.
  var flights = Flight.allFlights()
  
  //this to remember which table row was selected when presenting the two interface controllers
  var selectedIndex = 0

  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    // informing the table to create an instance of the row you just built in Interface Builder, for each flight in flights. The number of rows is equal to the size of the array, and the row type is the identifier set in storyboard
    flightsTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
    
    // iterating over each row in the table using a for loop, and asking the table for the row controller at the given index. If you successfully cast the controller, you’re handed back an instance of FlightRowController. Then set controller.flight to the corresponding flight item in the flights array. This triggers the didSet observer in FlightRowController, and configures all the labels in the table row.
    for index in 0..<flightsTable.numberOfRows {
      guard let controller = flightsTable.rowController(at: index) as? FlightRowController else { continue }
      
      controller.flight = flights[index]
    }
    
  }
  
  //retrieve the appropriate flight from flights using the row index passed into this method, then present the flight details interface, passing flight as the context
  override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
    let flight = flights[rowIndex]
    //checking whether or not the user has checked-in for the selected flight, and if so you present the flight details and boarding pass interface controllers. If they haven’t, present the flight details and check-in interface controllers instead.
    let controllers = flight.checkedIn ? ["Flight", "BoardingPass"] : ["Flight", "CheckIn"]
    
    //sets selectedIndex to the index of the selected table row
    selectedIndex = rowIndex
    //present the next screen
    presentController(withNames: controllers, contexts: [flight, flight])
  }
  
  override func didAppear() {
    super.didAppear()
    
    // check to see if the selected flight is checked-in. If so, you try to cast the row controller, at the corresponding index in the table, to an instance of FlightRowController.
    guard flights[selectedIndex].checkedIn,
      let controller = flightsTable.rowController(at: selectedIndex) as? FlightRowController else {
        return
    }
    
    // If that succeeds, you use the animation API on WKInterfaceController to execute the given closure, over a duration of 0.35 seconds.
    animate(withDuration: 0.35) {
      
      // In the closure, you call the method you just added to FlightRowController, which changes the color of the plane image and separator of that table row, and provides users with some visual feedback that they’re now checked-in.
      controller.updateForCheckIn()
    }
  }
  
}
