//
//  CheckInInterfaceController.swift
//  AirAber
//
//  Created by Robert Martin on 11/24/16.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation

//updates ScheduleInterfaceController to show it.
class CheckInInterfaceController: WKInterfaceController {

  @IBOutlet var backgroundGroup: WKInterfaceGroup!
  @IBOutlet var originLabel: WKInterfaceLabel!
  @IBOutlet var destinationLabel: WKInterfaceLabel!

  var flight: Flight? {
    didSet {
      guard let flight = flight else { return }
      
      originLabel.setText(flight.origin)
      destinationLabel.setText(flight.destination)
    }
  }
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    if let flight = context as? Flight {
      self.flight = flight
    }
  }

  @IBAction func checkInButtonTapped() {
    
    // create two constants: one for the duration of the animation, and one for the delay after which the controller will be dismissed. Instead of being a Double, delay is an instance of DispatchTime since you’ll be using it with Grand Central Dispatch
    let duration = 0.35
    let delay = DispatchTime.now() + Double(Int64((duration + 0.15) *
      Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    
    // load a sequence of images named Progress and set them as the background image of backgroundGroup. Remember that layout groups conform to WKImageAnimatable, which allows you to use them to play back animated image sequences.
    backgroundGroup.setBackgroundImageNamed("Progress")
    
    // begin playback of the image sequence. The range you supply covers the entire sequence, and a repeatCount of 1 means the animation will play just once.
    backgroundGroup.startAnimatingWithImages(in: NSRange(location: 0, length: 10),
                                             duration: duration,
                                             repeatCount: 1)
    // WatchKit doesn’t have completion handlers, so you use Grand Central Dispatch to execute the closure after the given delay.
    DispatchQueue.main.asyncAfter(deadline: delay) { [weak self] in
      
      // In the closure, mark flight as checked-in, and then dismiss the controller.
      self?.flight?.checkedIn = true
      self?.dismiss()
    }
  }

  
  
}
