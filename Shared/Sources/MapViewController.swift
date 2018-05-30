//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import MapKit
import UIKit

@available(tvOS 9.2, *)
final class MapViewController: RevertViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    self.addAnnotations()

    self.mapView.region = Static.Region.Australia
  }

  // MARK: Private

  fileprivate static let overlayLineWidth: CGFloat = 3
  fileprivate static let overlayFillColor = UIColor.revertTint.withAlphaComponent(0.5)
  fileprivate static let overlayStrokeColor = UIColor.revertDarkBlue

  @IBOutlet private var mapView: MKMapView!

  private func addAnnotations() {
    let locations = RevertItems.mapLocations.data
    let annotations = locations.map(MapAnnotation.init)
    var coordinates = annotations.map { $0.coordinate }

    self.mapView.addAnnotations(annotations)
    self.mapView.add(MKPolygon(coordinates: &coordinates, count: coordinates.count))
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
