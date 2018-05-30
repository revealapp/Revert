//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import MapKit

final class MapAnnotation: NSObject, MKAnnotation {
  let coordinate: CLLocationCoordinate2D
  let title: String?
  let subtitle: String?

  init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle

    super.init()
  }

  init(dictionary: [String: AnyObject]) {
    guard
      let latitude = dictionary[Attributes.latitude.rawValue] as? Double,
      let longitude = dictionary[Attributes.longitude.rawValue] as? Double,
      let title = dictionary[Attributes.title.rawValue] as? String,
      let subtitle = dictionary[Attributes.subtitle.rawValue] as? String
    else {
      fatalError("Invalid `MapAnnotation` attributes")
    }

    self.title = title
    self.subtitle = subtitle
    self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

    super.init()
  }

  // MARK: Private

  private enum Attributes: String {
    case title
    case subtitle
    case latitude
    case longitude
  }
}
