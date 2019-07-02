//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.file` struct is generated, and contains static references to 1 files.
  struct file {
    /// Resource file `Countries.bundle`.
    static let countriesBundle = Rswift.FileResource(bundle: R.hostingBundle, name: "Countries", pathExtension: "bundle")
    
    /// `bundle.url(forResource: "Countries", withExtension: "bundle")`
    static func countriesBundle(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.countriesBundle
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 4 images.
  struct image {
    /// Image `RegistrationNotView`.
    static let registrationNotView = Rswift.ImageResource(bundle: R.hostingBundle, name: "RegistrationNotView")
    /// Image `RegistrationView`.
    static let registrationView = Rswift.ImageResource(bundle: R.hostingBundle, name: "RegistrationView")
    /// Image `error`.
    static let error = Rswift.ImageResource(bundle: R.hostingBundle, name: "error")
    /// Image `offline`.
    static let offline = Rswift.ImageResource(bundle: R.hostingBundle, name: "offline")
    
    /// `UIImage(named: "RegistrationNotView", bundle: ..., traitCollection: ...)`
    static func registrationNotView(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.registrationNotView, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "RegistrationView", bundle: ..., traitCollection: ...)`
    static func registrationView(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.registrationView, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "error", bundle: ..., traitCollection: ...)`
    static func error(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.error, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "offline", bundle: ..., traitCollection: ...)`
    static func offline(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.offline, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 5 storyboards.
  struct storyboard {
    /// Storyboard `BaseWebView`.
    static let baseWebView = _R.storyboard.baseWebView()
    /// Storyboard `ChangePassword`.
    static let changePassword = _R.storyboard.changePassword()
    /// Storyboard `Initial`.
    static let initial = _R.storyboard.initial()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `PinVerification`.
    static let pinVerification = _R.storyboard.pinVerification()
    
    /// `UIStoryboard(name: "BaseWebView", bundle: ...)`
    static func baseWebView(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.baseWebView)
    }
    
    /// `UIStoryboard(name: "ChangePassword", bundle: ...)`
    static func changePassword(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.changePassword)
    }
    
    /// `UIStoryboard(name: "Initial", bundle: ...)`
    static func initial(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.initial)
    }
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "PinVerification", bundle: ...)`
    static func pinVerification(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.pinVerification)
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try baseWebView.validate()
      try changePassword.validate()
      try initial.validate()
      try launchScreen.validate()
      try pinVerification.validate()
    }
    
    struct baseWebView: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = BaseWebViewViewController
      
      let baseWebViewViewControllerVC = StoryboardViewControllerResource<BaseWebViewViewController>(identifier: "BaseWebViewViewControllerVC")
      let bundle = R.hostingBundle
      let name = "BaseWebView"
      
      func baseWebViewViewControllerVC(_: Void = ()) -> BaseWebViewViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: baseWebViewViewControllerVC)
      }
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.baseWebView().baseWebViewViewControllerVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'baseWebViewViewControllerVC' could not be loaded from storyboard 'BaseWebView' as 'BaseWebViewViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct changePassword: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let changePasswordViewControllerTableVC = StoryboardViewControllerResource<ChangePasswordViewController>(identifier: "ChangePasswordViewControllerTableVC")
      let name = "ChangePassword"
      
      func changePasswordViewControllerTableVC(_: Void = ()) -> ChangePasswordViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: changePasswordViewControllerTableVC)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "RegistrationNotView", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'RegistrationNotView' is used in storyboard 'ChangePassword', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.changePassword().changePasswordViewControllerTableVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'changePasswordViewControllerTableVC' could not be loaded from storyboard 'ChangePassword' as 'ChangePasswordViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct initial: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = InitialViewController
      
      let bundle = R.hostingBundle
      let initialViewControllerVC = StoryboardViewControllerResource<InitialViewController>(identifier: "InitialViewControllerVC")
      let name = "Initial"
      
      func initialViewControllerVC(_: Void = ()) -> InitialViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: initialViewControllerVC)
      }
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.initial().initialViewControllerVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'initialViewControllerVC' could not be loaded from storyboard 'Initial' as 'InitialViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct pinVerification: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = BaseNavigationController
      
      let bundle = R.hostingBundle
      let name = "PinVerification"
      let pinVerificationNav = StoryboardViewControllerResource<BaseNavigationController>(identifier: "pinVerificationNav")
      let pinVerificationViewControllerTableVC = StoryboardViewControllerResource<PinVerificationViewController>(identifier: "PinVerificationViewControllerTableVC")
      
      func pinVerificationNav(_: Void = ()) -> BaseNavigationController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: pinVerificationNav)
      }
      
      func pinVerificationViewControllerTableVC(_: Void = ()) -> PinVerificationViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: pinVerificationViewControllerTableVC)
      }
      
      static func validate() throws {
        if #available(iOS 11.0, *) {
        }
        if _R.storyboard.pinVerification().pinVerificationViewControllerTableVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'pinVerificationViewControllerTableVC' could not be loaded from storyboard 'PinVerification' as 'PinVerificationViewController'.") }
        if _R.storyboard.pinVerification().pinVerificationNav() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'pinVerificationNav' could not be loaded from storyboard 'PinVerification' as 'BaseNavigationController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
