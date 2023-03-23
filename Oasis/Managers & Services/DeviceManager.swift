

import AudioToolbox
import UIKit

class DeviceManager {
    private init() {}

    static let current =  DeviceManager()

    /// returns that status bar height of the device
    var statusBarHeight : CGFloat {
        return UIApplication.shared.statusBarFrame.height
        
    }
    
    func vibrateDevice(completionHandler : ( () -> Void )?){
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate) {
            completionHandler?()
        }
    }
    
    
    /// Generate notification feedback to communicate that a task or action has succeeded, failed, or produced a warning of some kind..
    ///
    /// - Parameter type: Types of haptic notification
    func generateHaptic(type : NotificationHaptic){
        guard let value = type.value else {
            return
        }
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(value)
    }
    
    /// Generate impact feedback to indicate that an impact has occurred.
    /// For example, you might trigger impact feedback when a user interface object collides with another object or snaps into place.
    ///
    /// - Parameter style: Physical impacts haptic style.
    func generateImpact(style : ImpactFeedback){
        guard let value = style.value else {
            return
        }
        let generator = UIImpactFeedbackGenerator(style: value)
        generator.impactOccurred()
    }
    
    
    /// Genereate haptics to indicate a change in selection.
    func generateSelectionFeedback(){
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}
