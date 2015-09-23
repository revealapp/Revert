//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation
import MapKit

struct Constants {
  struct Region {
    static let Australia: MKCoordinateRegion = {
      let center = CLLocationCoordinate2D(latitude: -24.291451, longitude: 134.126772)
      let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
      return MKCoordinateRegion(center: center, span: span)
    }()
  }
}

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