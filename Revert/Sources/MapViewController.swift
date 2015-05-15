//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: ViewController {
  @IBOutlet weak var mapView: MKMapView!

  override func viewDidLoad() {
    super.viewDidLoad()

    self.addAnnotations()
  }
  
  private func addAnnotations() {
    let locations = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("MapLocations", ofType: "plist")!) as! [[String: AnyObject]]
    let annotations = locations.map({MapAnnotation(dictionary: $0)})
    var coordinates = annotations.map({$0.coordinate}) + [annotations.first!.coordinate]
    
    self.mapView.addAnnotations(annotations)
    self.mapView.addOverlay(MKPolygon(coordinates: &coordinates, count: coordinates.count))
  }
}

// MARK: MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
  func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
    if (overlay is MKPolygon) {
      let pr = MKPolygonRenderer(overlay: overlay)
      pr.strokeColor = UIColor.revertDarkblueColor()
      pr.fillColor = UIColor.revertTintColor().colorWithAlphaComponent(0.5)
      pr.lineWidth = 3
      return pr
    }
    return nil
  }
}