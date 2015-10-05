//
//  RevertItems.swift
//  Revert
//
//  Created by Hugo Cuvillier on 23/09/2015.
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.
//

enum RevertItems: String {
  case CountriesCapitals
  case Alert = "AlertItems"
  case Home = "HomeItems"
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

  private var invalidContentError: String {
    return "Invalid content: \(self.rawValue).\(self.dynamicType.fileExtension)"
  }

  private var invalidFileError: String {
    return "Invalid file: \(self.rawValue).\(self.dynamicType.fileExtension)"
  }

  private var url: NSURL {
    guard let bundle = NSBundle.mainBundle().URLForResource(self.rawValue, withExtension: self.dynamicType.fileExtension) else {
      fatalError(self.invalidFileError)
    }
    return bundle
  }

  private static let fileExtension = "plist"
}