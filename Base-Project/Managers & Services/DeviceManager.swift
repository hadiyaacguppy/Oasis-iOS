import UIKit
import Foundation
import DeviceKit
class DeviceManager {
    
    /// Returns if this device is an iPHONE. real or simulator.
    var isPhone  : Bool {
        return Device().isPhone
    }
    /// Returns if the device is a real iPhone
    var isRealiPhone : Bool {
        return Device().isPhone && !Device().isSimulator
    }
    
    /// Returns true is this device is an iPad. Real or Simulator
    var iPad : Bool {
        return Device().isPad
    }
    /// Returns if the device is a real iPad
    var isRealiPad : Bool {
        return Device().isPad && !Device().isSimulator
    }
    
    /// Returns true is app is running on a Simulator
    var isSimulator: Bool {
        return Device().isSimulator
    }
    
    /// Returns true if app is running on an X-Series Device. iPhoneX iPhoneXs iPhoneXsMax iPhoneXr]
    var isXSeries : Bool{
        return Device().isOneOf(Device.allXSeriesDevices)
    }
    /// Returns true if app is running on Real X-Series Device. iPhoneX iPhoneXs iPhoneXsMax iPhoneXr]
    var isRealXSeries : Bool {
        return Device().isOneOf(Device.allXSeriesDevices) && !Device().isSimulator
    }
    
    /// Returns true if device has FaceID or TouchID
    var hasBiometricScanner : Bool {
        return Device().hasBiometricSensor
    }
    /// Returns the name of the device. For example : 'Wassim's iPhone X', 'Hadi's iPhone'
    var deviceName : String {
        return Device().name
    }
    /// Returns the iOS version as string. (e.g. 8.4 or 9.2).
    var iOSVersion : String {
        return Device().systemVersion
    }
    /// Returns the screen brightness of the device
    var screenBrightness : Int {
        return Device().screenBrightness
    }
    /// Returns if the current device is charging
    var isCharging : Bool {
        switch Device().batteryState {
        case  .charging:
            return true
        default:
            return false
        }
    }
    /// Returns true if the battery is full
    var isBatteryFull : Bool{
        return Device().batteryState == .full
    }
    /// Return true if the phone is not plugged to power
    var isUnPlugged : Bool {
        switch Device().batteryState {
        case  .unplugged:
            return true
        default:
            return false
        }
    }
    /// Returns the battery level of the device
    var batteryLevel : Int {
        return Device().batteryLevel
    }
    /// returns true if device is low power mode
    var isLowPowerModeEnabled : Bool {
        return Device().batteryState.lowPowerMode
    }
    /// returns that status bar height of the device
    var statusBarHeight : CGFloat {
        return UIApplication.shared.statusBarFrame.height
        
    }
}
