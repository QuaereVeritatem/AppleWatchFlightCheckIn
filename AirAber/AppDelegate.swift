

//working..swift 3 and xcode 9 ready ..doesnt show QRCode though

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  var session: WCSession? {
    didSet {
      if let session = session {
        session.delegate = self
        session.activate()
      }
    }
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    //Here you make sure Watch Connectivity is supported, and if it is you set session to the default session singleton provided by the framework.
    if WCSession.isSupported() {
      session = WCSession.default()
    }
    return true
  }
}


//implement the WCSessionDelegate method responsible for receiving realtime messages. In it, you extract the flight reference from the dictionary you passed above, and then use that to generate a QR code with the amazing QRCode library from Alexander Schuch. If that’s successful then you call the reply handler, passing the image data back to the watch app.
extension AppDelegate: WCSessionDelegate {
  
  /** Called when all delegate callbacks for the previously selected watch has occurred. The session can be re-activated for the now selected watch using activateSession. */
  @available(iOS 9.3, *)
  public func sessionDidDeactivate(_ session: WCSession) {
    //
  }
  
  /** Called when the session can no longer be used to modify or add any new transfers and, all interactive messages will be cancelled, but delegate callbacks for background transfers can still occur. This will happen when the selected watch is being changed. */
  @available(iOS 9.3, *)
  public func sessionDidBecomeInactive(_ session: WCSession) {
    //
  }
  
  /** Called when the session has completed activation. If session state is WCSessionActivationStateNotActivated there will be an error with more details. */
  @available(iOS 9.3, *)
  public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    //
  }

  
  func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
    if let reference = message["reference"] as? String, let boardingPass = QRCode(reference) {
      replyHandler(["boardingPassData": boardingPass.PNGData as AnyObject])
    }
  }
  

  
}




