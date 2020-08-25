//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import MapKit

final class MapAnnotation: NSObject, MKAnnotation {
  let coordinate: CLLocationCoordinate2D
  let title: String?
  let subtitle: String?

  init(mapLocation: MapLocationItem) {
    let latitude = mapLocation.latitude
    let longitude = mapLocation.longitude

    self.title = mapLocation.title
    self.subtitle = mapLocation.subtitle
    self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

    super.init()
  }
}
