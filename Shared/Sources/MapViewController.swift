//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit
import MapKit

@available(tvOS 9.2, *)
final class MapViewController: RevertViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    self.addAnnotations()

    self.mapView.region = Static.Region.Australia
  }

  // MARK: Private

  fileprivate static let overlayLineWidth: CGFloat = 3
  fileprivate static let overlayFillColor = UIColor(#colorLiteral(red: 0.208, green: 0.682, blue: 0.929, alpha: 1)).withAlphaComponent(0.5)
  fileprivate static let overlayStrokeColor = #colorLiteral(red: 0.217, green: 0.372, blue: 1, alpha: 1)

  @IBOutlet private weak var mapView: MKMapView!

  private func addAnnotations() {
    let locations: [MapLocationItem] = RevertItems.mapLocations.Data()
    let annotations = locations.map(MapAnnotation.init)
    var coordinates = annotations.map { $0.coordinate }

    self.mapView.addAnnotations(annotations)
    self.mapView.addOverlay(MKPolygon(coordinates: &coordinates, count: coordinates.count))
  }
}

// MARK: - MKMapViewDelegate
@available(tvOS 9.2, *)
extension MapViewController: MKMapViewDelegate {

  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    if overlay is MKPolygon {
      let pr = MKPolygonRenderer(overlay: overlay)
      pr.strokeColor = type(of: self).overlayStrokeColor
      pr.fillColor = type(of: self).overlayFillColor
      pr.lineWidth = type(of: self).overlayLineWidth
      return pr
    } else {
      return MKOverlayRenderer(overlay: overlay)
    }
  }
}
