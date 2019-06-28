//
//  FeedbacksType.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 6/28/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit

///  Physical impacts haptic style.
///
/// - light: A collision between small, light user interface elements.
/// - medium: A collision between moderately sized user interface elements.
/// - heavy: A collision between large, heavy user interface elements.
/// - none: none
enum ImpactFeedback {
    case light
    case medium
    case heavy
    case none
    
    @available(iOS 10.0, *)
    var value: UIImpactFeedbackGenerator.FeedbackStyle? {
        switch self {
        case .light:
            return .light
        case .medium:
            return .medium
        case .heavy:
            return .heavy
        case .none:
            return nil
        }
    }
    
    var isValid: Bool {
        return self != .none
    }
}

/// Types of haptic notification
///
/// - success: A notification feedback type, indicating that a task has completed successfully.
/// - warning-: A notification feedback type, indicating that a task has produced a warning.
/// - error: A notification feedback type, indicating that a task has failed.
/// - none: none
enum NotificationHaptic {
    case success
    case warning
    case error
    case none
    
    @available(iOS 10.0, *)
    var value: UINotificationFeedbackGenerator.FeedbackType? {
        switch self {
        case .success:
            return .success
        case .warning:
            return .warning
        case .error:
            return .error
        case .none:
            return nil
        }
    }
    
    var isValid: Bool {
        return self != .none
    }
}
