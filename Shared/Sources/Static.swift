//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation
import MapKit

struct Static {
  struct Formatter {
    static var ddmmyy: NSDateFormatter = {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "dd MMM YYYY"
      return dateFormatter
    }()

    static var decimal: NSNumberFormatter = {
      let numberFormatter = NSNumberFormatter()
      numberFormatter.alwaysShowsDecimalSeparator = true
      numberFormatter.locale = NSLocale.currentLocale()
      numberFormatter.maximumFractionDigits = 2
      numberFormatter.minimumFractionDigits = 1
      numberFormatter.minimumIntegerDigits = 1
      return numberFormatter
    }()
  }

  struct Region {
    static let Australia: MKCoordinateRegion = {
      let center = CLLocationCoordinate2D(latitude: -24.291451, longitude: 134.126772)
      let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
      return MKCoordinateRegion(center: center, span: span)
    }()
  }
}
