//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import MapKit

final class MapAnnotation: NSObject, MKAnnotation {
  private enum Attributes: String {
    case Title = "title"
    case Subtitle = "subtitle"
    case Latitude = "latitude"
    case Longitude = "londitude"
  }
  
  let coordinate: CLLocationCoordinate2D
  let title: String
  let subtitle: String

  init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
    
    super.init()
  }
  
  init(dictionary: [String: AnyObject]) {
    if let latitude = dictionary[Attributes.Latitude.rawValue] as? Double,
      longitude = dictionary[Attributes.Longitude.rawValue] as? Double,
      title = dictionary[Attributes.Title.rawValue] as? String,
      subtitle = dictionary[Attributes.Subtitle.rawValue] as? String {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    } else {
      fatalError("Invalid MapAnnotation attributes")
    }
    
    super.init()
  }
}
