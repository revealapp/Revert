//
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
      let latitude = dictionary[Attributes.Latitude.rawValue] as? Double,
      let longitude = dictionary[Attributes.Longitude.rawValue] as? Double,
      let title = dictionary[Attributes.Title.rawValue] as? String,
      let subtitle = dictionary[Attributes.Subtitle.rawValue] as? String
    else {
      fatalError("Invalid `MapAnnotation` attributes")
    }

    self.title = title
    self.subtitle = subtitle
    self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

    super.init()
  }

  // MARK: Private

  fileprivate enum Attributes: String {
    case Title = "title"
    case Subtitle = "subtitle"
    case Latitude = "latitude"
    case Longitude = "longitude"
  }
}
