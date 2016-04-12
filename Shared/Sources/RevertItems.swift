//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.
//

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
    guard let data = NSArray(contentsOfURL: self.URL) as? [[String: AnyObject]] else {
      fatalError(self.invalidContentError)
    }
    return data
  }

  // MARK: Private
  private static let fileExtension = "plist"
  private static let subfolder = "Data"

  private var invalidContentError: String {
    return "Invalid content: \(self.rawValue).\(self.dynamicType.fileExtension)"
  }

  private var invalidFileError: String {
    return "Invalid file: No common or platform-specific \(self.rawValue) files exist"
  }

  private var URL: NSURL {
    var URL: NSURL? {
      let commonPath = "\(self.dynamicType.subfolder)/\(self.rawValue)"
      let platformPath = "\(commonPath)\(self.dynamicType.platformSuffix)"

      if let platformURL = NSBundle.mainBundle().URLForResource(platformPath, withExtension: self.dynamicType.fileExtension) {
        return platformURL
      } else {
        let commonURL = NSBundle.mainBundle().URLForResource(commonPath, withExtension: self.dynamicType.fileExtension)
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
    private static let platformSuffix = "_iOS"
  #endif

  #if os(tvOS)
    private static let platformSuffix = "_tvOS"
  #endif
}
