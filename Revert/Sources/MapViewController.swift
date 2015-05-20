//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: RevertViewController {
  @IBOutlet weak var mapView: MKMapView!

  private let overlayLineWidth: CGFloat = 3
  private let overlayFillColor = UIColor.revertTintColor().colorWithAlphaComponent(0.5)
  private let overlayStrokeColor = UIColor.revertDarkblueColor()

  override func viewDidLoad() {
    super.viewDidLoad()

    self.addAnnotations()
    
    self.mapView.region = self.dynamicType.ozRegion
  }
  
  private static var ozRegion: MKCoordinateRegion {
    let center = CLLocationCoordinate2D(latitude: -24.291451, longitude: 134.126772)
    let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
    return MKCoordinateRegion(center: center, span: span)
  }
  
  private func addAnnotations() {
    if let locations = NSArray(contentsOfFile: NSBundle.mainBundle().pathForResource("MapLocations", ofType: "plist")!) as? [[String: AnyObject]] {
      let annotations = locations.map({MapAnnotation(dictionary: $0)})
      var coordinates = annotations.map({$0.coordinate})
      
      self.mapView.addAnnotations(annotations)
      self.mapView.addOverlay(MKPolygon(coordinates: &coordinates, count: coordinates.count))
    } else {
      fatalError("MapLocations.plist file not valid")
    }
  }
}

// MARK: MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
  func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
    if (overlay is MKPolygon) {
      let pr = MKPolygonRenderer(overlay: overlay)
      pr.strokeColor = self.overlayStrokeColor
      pr.fillColor = self.overlayFillColor
      pr.lineWidth = self.overlayLineWidth
      return pr
    }
    return nil
  }
}