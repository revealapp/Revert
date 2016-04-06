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
  case View = "ViewItems"

  var data: [[String: AnyObject]] {
    guard let data = NSArray(contentsOfURL: self.url) as? [[String: AnyObject]] else {
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
    return "Invalid file: \(self.rawValue).\(self.dynamicType.fileExtension)"
  }

  private var url: NSURL {
    let path = "\(self.dynamicType.subfolder)/\(self.rawValue)"
    guard let bundle = NSBundle.mainBundle().URLForResource(path, withExtension: self.dynamicType.fileExtension) else {
      fatalError(self.invalidFileError)
    }
    return bundle
  }
}
