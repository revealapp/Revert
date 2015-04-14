//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import MapKit

class MapAnnotation: NSObject, MKAnnotation {
  init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
    
    super.init()
  }
  
  init(dictionary: [String: AnyObject]) {
    let latitude = dictionary["latitude"] as! Double
    let longitude = dictionary["longitude"] as! Double
    
    self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    self.title = dictionary["title"] as! String
    self.subtitle = dictionary["subtitle"] as! String
    
    super.init()
  }
  
  var coordinate: CLLocationCoordinate2D
  var title: String
  var subtitle: String
}
