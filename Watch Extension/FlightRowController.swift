//
//  FlightRowController.swift
//  AirAber
//
//  Created by Robert Martin on 11/21/16.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import WatchKit

class FlightRowController: NSObject {
  
  @IBOutlet var separator: WKInterfaceSeparator!
  @IBOutlet var originLabel: WKInterfaceLabel!
  @IBOutlet var destinationLabel: WKInterfaceLabel!
  @IBOutlet var flightNumberLabel: WKInterfaceLabel!
  @IBOutlet var statusLabel: WKInterfaceLabel!
  @IBOutlet var planeImage: WKInterfaceImage!
  
  // an optional property of type Flight
  var flight: Flight? {
    
    // add a property observer that is triggered whenever the property is set
    didSet {
      
      // exit early if flight is nil: it’s an optional and you want to proceed with configuring the labels only when you have a valid instance of Flight
      guard let flight = flight else { return }
      
      // configuring the labels using the relevant properties of flight
      originLabel.setText(flight.origin)
      destinationLabel.setText(flight.destination)
      flightNumberLabel.setText(flight.number)
      
      // If flight delayed, change the text color of the label to red, and update the text to reflect that.

      if flight.onSchedule {
        statusLabel.setText("On Time")
      } else {
        statusLabel.setText("Delayed")
        statusLabel.setTextColor(.red)
      }
    }
  }
  
  //creating an instance of UIColor, then using it to set the tint color and color of planeImage and separator, respectively. This method will be called from within an animation closure, so the color change will animate nicely.
  func updateForCheckIn() {
    let color = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
    planeImage.setTintColor(color)
    separator.setColor(color)
  }

}
