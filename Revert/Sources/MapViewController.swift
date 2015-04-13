//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit
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

class MapViewController: UIViewController {
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.addAnnotations()
  }
  
  private func addAnnotations() {
    let locations = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("MapLocations", ofType: "plist")!) as! [[String: AnyObject]]
    let annotations = locations.map({MapAnnotation(dictionary: $0)})
    var coordinates = annotations.map({$0.coordinate}) + [annotations.first!.coordinate]
    var polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
    
    self.mapView.addAnnotations(annotations)
    self.mapView.addOverlay(polyline)
  }
}

// MARK: MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
  func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
    if (overlay is MKPolyline) {
      var pr = MKPolylineRenderer(overlay: overlay)
      pr.strokeColor = UIColor.alizarinColor().colorWithAlphaComponent(0.5)
      pr.lineWidth = 2.0
      return pr
    }
    return nil
  }
}