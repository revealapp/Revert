//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

enum RevertItems: String {
  case CountriesCapitals
  case Alert = "AlertItems"
  case Home = "HomeItems"
  case HomeCollection = "HomeCollectionItems"
  case Control = "ControlItems"
  case MapLocations = "MapLocations"
  case LayerProperties = "LayerPropertiesItems"
  case Persons = "Persons"
  case View = "ViewItems"
  case WhatsNew = "NewItems"

  var data: [[String: AnyObject]] {
    guard let data = NSArray(contentsOf: self.URL) as? [[String: AnyObject]] else {
      fatalError(self.invalidContentError)
    }
    return data
  }

  // MARK: Private
  fileprivate static let fileExtension = "plist"
  fileprivate static let subfolder = "Data"

  fileprivate var invalidContentError: String {
    return "Invalid content: \(self.rawValue).\(type(of: self).fileExtension)"
  }

  fileprivate var invalidFileError: String {
    return "Invalid file: No common or platform-specific \(self.rawValue) files exist"
  }

  fileprivate var URL: Foundation.URL {
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
