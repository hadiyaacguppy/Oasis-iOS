//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 3 storyboards.
  struct storyboard {
    /// Storyboard `Initial`.
    static let initial = _R.storyboard.initial()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `PushNotification`.
    static let pushNotification = _R.storyboard.pushNotification()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Initial", bundle: ...)`
    static func initial(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.initial)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "PushNotification", bundle: ...)`
    static func pushNotification(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.pushNotification)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.entitlements` struct is generated, and contains static references to 1 properties.
  struct entitlements {
    static let apsEnvironment = infoPlistString(path: [], key: "aps-environment") ?? "development"

    fileprivate init() {}
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

  /// This `R.image` struct is generated, and contains static references to 7 images.
  struct image {
    /// Image `NavBackAr`.
    static let navBackAr = Rswift.ImageResource(bundle: R.hostingBundle, name: "NavBackAr")
    /// Image `NavBack`.
    static let navBack = Rswift.ImageResource(bundle: R.hostingBundle, name: "NavBack")
    /// Image `NavClose`.
    static let navClose = Rswift.ImageResource(bundle: R.hostingBundle, name: "NavClose")
    /// Image `RegistrationNotView`.
    static let registrationNotView = Rswift.ImageResource(bundle: R.hostingBundle, name: "RegistrationNotView")
    /// Image `RegistrationView`.
    static let registrationView = Rswift.ImageResource(bundle: R.hostingBundle, name: "RegistrationView")
    /// Image `error`.
    static let error = Rswift.ImageResource(bundle: R.hostingBundle, name: "error")
    /// Image `offline`.
    static let offline = Rswift.ImageResource(bundle: R.hostingBundle, name: "offline")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "NavBack", bundle: ..., traitCollection: ...)`
    static func navBack(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.navBack, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "NavBackAr", bundle: ..., traitCollection: ...)`
    static func navBackAr(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.navBackAr, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "NavClose", bundle: ..., traitCollection: ...)`
    static func navClose(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.navClose, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "RegistrationNotView", bundle: ..., traitCollection: ...)`
    static func registrationNotView(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.registrationNotView, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "RegistrationView", bundle: ..., traitCollection: ...)`
    static func registrationView(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.registrationView, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "error", bundle: ..., traitCollection: ...)`
    static func error(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.error, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "offline", bundle: ..., traitCollection: ...)`
    static func offline(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.offline, compatibleWith: traitCollection)
    }
    #endif

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
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try initial.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try pushNotification.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct initial: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = InitialViewController

      let bundle = R.hostingBundle
      let initialViewControllerVC = StoryboardViewControllerResource<InitialViewController>(identifier: "InitialViewControllerVC")
      let name = "Initial"

      func initialViewControllerVC(_: Void = ()) -> InitialViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: initialViewControllerVC)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.initial().initialViewControllerVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'initialViewControllerVC' could not be loaded from storyboard 'Initial' as 'InitialViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct pushNotification: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = BaseNavigationController

      let bundle = R.hostingBundle
      let name = "PushNotification"
      let pushNotificationContainer = StoryboardViewControllerResource<PushNotificationContainer>(identifier: "PushNotificationContainer")
      let pushNotificationMessageController = StoryboardViewControllerResource<PushNotificationMessageController>(identifier: "PushNotificationMessageController")
      let pushNotificationNavVC = StoryboardViewControllerResource<BaseNavigationController>(identifier: "PushNotificationNavVC")

      func pushNotificationContainer(_: Void = ()) -> PushNotificationContainer? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: pushNotificationContainer)
      }

      func pushNotificationMessageController(_: Void = ()) -> PushNotificationMessageController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: pushNotificationMessageController)
      }

      func pushNotificationNavVC(_: Void = ()) -> BaseNavigationController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: pushNotificationNavVC)
      }

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.pushNotification().pushNotificationContainer() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'pushNotificationContainer' could not be loaded from storyboard 'PushNotification' as 'PushNotificationContainer'.") }
        if _R.storyboard.pushNotification().pushNotificationMessageController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'pushNotificationMessageController' could not be loaded from storyboard 'PushNotification' as 'PushNotificationMessageController'.") }
        if _R.storyboard.pushNotification().pushNotificationNavVC() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'pushNotificationNavVC' could not be loaded from storyboard 'PushNotification' as 'BaseNavigationController'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
