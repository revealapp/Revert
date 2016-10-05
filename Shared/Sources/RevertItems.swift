//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

enum RevertItems: String {
  case capitalCities
  case alert = "AlertItems"
  case home = "HomeItems"
  case homeCollection = "HomeCollectionItems"
  case control = "ControlItems"
  case mapLocations = "MapLocations"
  case layerProperties = "LayerPropertiesItems"
  case persons = "Persons"
  case view = "ViewItems"
  case whatsNew = "NewItems"

  var data: [[String: AnyObject]] {
    guard let data = NSArray(contentsOf: self.URL) as? [[String: AnyObject]] else {
      fatalError(self.invalidContentError)
    }
    return data
  }

  // MARK: Private

  private static let fileExtension = "plist"
  private static let subfolder = "Data"

  private var invalidContentError: String {
    return "Invalid content: \(self.rawValue).\(type(of: self).fileExtension)"
  }

  private var invalidFileError: String {
    return "Invalid file: No common or platform-specific \(self.rawValue) files exist"
  }

  private var URL: Foundation.URL {
    var URL: Foundation.URL? {
      let commonPath = "\(type(of: self).subfolder)/\(self.rawValue)"
      let platformPath = "\(commonPath)\(type(of: self).platformSuffix)"

      if let platformURL = Bundle.main.url(forResource: platformPath, withExtension: type(of: self).fileExtension) {
        return platformURL
      } else {
        let commonURL = Bundle.main.url(forResource: commonPath, withExtension: type(of: self).fileExtension)
        return commonURL
      }
    }

    guard let fileURL = URL else {
      fatalError(self.invalidFileError)
    }
    return fileURL
  }
}

extension RevertItems {
  #if os(iOS)
    fileprivate static let platformSuffix = "_iOS"
  #endif

  #if os(tvOS)
    fileprivate static let platformSuffix = "_tvOS"
  #endif
}
