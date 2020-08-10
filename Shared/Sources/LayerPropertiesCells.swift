//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

class LayerBackedCollectionViewCell: CollectionViewCell {

#if os(tvOS)
  override func awakeFromNib() {
    // Ensure that there is a valid frame for the cell before trying to configure the layer effects/contents
    self.layoutIfNeeded()
    super.awakeFromNib()
  }
#endif

}

final class CATextLayerCell: LayerBackedCollectionViewCell {

  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureTextLayer(self.textLayerView.textLayer)
  }

  // MARK: Private

  @IBOutlet private weak var textLayerView: CATextLayerView!

  private static func configureTextLayer(_ textLayer: CATextLayer) {
    textLayer.string = NSLocalizedString("I am a quite long CATextLayer string.", comment: "")
    textLayer.fontSize = 20
    textLayer.foregroundColor = UIColor.lightGray.cgColor
    textLayer.alignmentMode = .center
    textLayer.truncationMode = .middle
    textLayer.isWrapped = true
  }
}

final class CAEmitterLayerCell: LayerBackedCollectionViewCell {

  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureEmitterLayer(self.emitterLayerView.emitterLayer)
  }

  // MARK: Private

  @IBOutlet private weak var emitterLayerView: CAEmitterLayerView!

  private static func configureEmitterLayer(_ emitterLayer: CAEmitterLayer) {
    emitterLayer.emitterPosition = CGPoint(x: emitterLayer.bounds.midX, y: emitterLayer.bounds.midY)
    emitterLayer.emitterZPosition = 5
    emitterLayer.emitterSize = CGSize(width: 1, height: 1)
    emitterLayer.emitterShape = .sphere
    emitterLayer.emitterDepth = 1.9
    emitterLayer.emitterShape = .point
    emitterLayer.emitterMode = .points
    emitterLayer.renderMode = .additive
    emitterLayer.emitterCells = [self.emitterCell]
  }

  private static var emitterCell: CAEmitterCell {
    let emitterCell = CAEmitterCell()
    emitterCell.scale = 0.05
    emitterCell.scaleRange = 0.02
    emitterCell.emissionRange = 2.0 * .pi
    emitterCell.lifetime = 10
    emitterCell.birthRate = 5
    emitterCell.velocity = 50
    emitterCell.velocityRange = 20
    emitterCell.yAcceleration = 250
    emitterCell.contents = UIImage(named: "spritekit_reveal")!.cgImage
    return emitterCell
  }
}

final class CAShapeLayerCell: LayerBackedCollectionViewCell {

  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureShapeLayer(self.shapeLayerView.shapeLayer)
  }

  // MARK: Private

  @IBOutlet private weak var shapeLayerView: CAShapeLayerView!

  private static func configureShapeLayer(_ shapeLayer: CAShapeLayer) {
    let minLength = min(shapeLayer.frame.height, shapeLayer.frame.width)
    let origin = CGPoint(x: (shapeLayer.bounds.width - minLength) / 2, y: 0)
    let rect = CGRect(origin: origin, size: CGSize(width: minLength, height: minLength))
    shapeLayer.path = UIBezierPath(ovalIn: rect).cgPath
    shapeLayer.fillColor = #colorLiteral(red: 0.992, green: 0.663, blue: 0.161, alpha: 1)
    shapeLayer.strokeColor = #colorLiteral(red: 0.156, green: 0.156, blue: 0.156, alpha: 1)
    shapeLayer.strokeStart = 0
    shapeLayer.strokeEnd = 1
    shapeLayer.fillRule = .evenOdd
    shapeLayer.lineWidth = 2
    shapeLayer.miterLimit = 5
    shapeLayer.lineCap = .round
    shapeLayer.lineJoin = .round
    shapeLayer.lineDashPhase = 1
    shapeLayer.lineDashPattern = [1, 3, 4, 2]
  }
}

final class CAScrollLayerCell: LayerBackedCollectionViewCell {
  @IBOutlet private weak var scrollLayerView: CAScrollLayerView!

  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureScrollLayer(self.scrollLayerView.scrollLayer)
  }

  private static func configureScrollLayer(_ scrollLayer: CAScrollLayer) {
    scrollLayer.scrollMode = .horizontally
    scrollLayer.backgroundColor = #colorLiteral(red: 0.217, green: 0.372, blue: 1, alpha: 1)
    scrollLayer.cornerRadius = 5
  }
}

final class CATiledLayerCell: LayerBackedCollectionViewCell {

  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureTiledLayer(self.tiledLayerView.tiledLayer)
  }

  // MARK: Private

  @IBOutlet private weak var tiledLayerView: CATiledLayerView!

  private static func configureTiledLayer(_ tiledLayer: CATiledLayer) {
    tiledLayer.levelsOfDetail = 10
    tiledLayer.levelsOfDetailBias = 10
    tiledLayer.tileSize = tiledLayer.bounds.size
    tiledLayer.cornerRadius = 5
    tiledLayer.borderWidth = 1
    tiledLayer.borderColor = #colorLiteral(red: 0.156, green: 0.156, blue: 0.156, alpha: 1)
  }
}

final class CAGradientLayerCell: LayerBackedCollectionViewCell {

  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureGradientLayer(self.gradientLayerView.gradientLayer)
  }

  // MARK: Private

  @IBOutlet private weak var gradientLayerView: CAGradientLayerView!

  private static func configureGradientLayer(_ gradientLayer: CAGradientLayer) {
    gradientLayer.type = .axial
    gradientLayer.locations = [0, 0.16, 0.31, 0.43, 0.5, 0.57, 0.69, 0.69, 0.69, 0.83, 1]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0)
    gradientLayer.endPoint = CGPoint(x: 0, y: 1)
    gradientLayer.cornerRadius = 5
    gradientLayer.colors = [
      UIColor(red: 0.003, green: 0.043, blue: 0.341, alpha: 1).cgColor,
      UIColor(red: 0.333, green: 0.000, blue: 0.533, alpha: 1).cgColor,
      UIColor(red: 0.611, green: 0.305, blue: 0.572, alpha: 1).cgColor,
      UIColor(red: 0.894, green: 0.611, blue: 0.611, alpha: 1).cgColor,
      UIColor(red: 1.000, green: 0.733, blue: 0.619, alpha: 1).cgColor,
      UIColor(red: 1.000, green: 0.866, blue: 0.517, alpha: 1).cgColor,
      UIColor.white.cgColor,
      UIColor(red: 0.894, green: 1.000, blue: 0.996, alpha: 1).cgColor,
      UIColor(red: 0.784, green: 1.000, blue: 0.996, alpha: 1).cgColor,
      UIColor(red: 0.223, green: 0.694, blue: 0.894, alpha: 1).cgColor,
      UIColor(red: 0.011, green: 0.360, blue: 0.576, alpha: 1).cgColor
    ]
  }
}

final class CAReplicatorLayerCell: LayerBackedCollectionViewCell {

  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureReplicatorLayer(self.replicatorLayerView.replicatorLayer)
  }

  // MARK: Private

  @IBOutlet private weak var replicatorLayerView: CAReplicatorLayerView!

  private static func configureReplicatorLayer(_ replicatorLayer: CAReplicatorLayer) {
    let circleWidth: CGFloat = 20
    let circlePadding: CGFloat = 10
    let circleRect = CGRect(x: circlePadding / 2, y: replicatorLayer.bounds.midY - circleWidth / 2, width: circleWidth, height: circleWidth)
    let circleLayer = CAShapeLayer()

    circleLayer.path = UIBezierPath(ovalIn: circleRect).cgPath
    circleLayer.fillColor = #colorLiteral(red: 0.992, green: 0.663, blue: 0.161, alpha: 1)

    replicatorLayer.instanceCount = 5
    replicatorLayer.preservesDepth = true
    replicatorLayer.instanceDelay = 1
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(circleWidth + circlePadding / 2, 0, 0)
    replicatorLayer.instanceColor = UIColor.red.cgColor
    replicatorLayer.instanceRedOffset = 0.2
    replicatorLayer.instanceGreenOffset = 0.3
    replicatorLayer.instanceBlueOffset = 0.1
    replicatorLayer.instanceAlphaOffset = 0.2
    replicatorLayer.addSublayer(circleLayer)
  }
}

final class CAEAGLLayerCell: LayerBackedCollectionViewCell {

  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureAeglLayer(self.aegLayerView.aeglLayer)
  }

  // MARK: Private

  @IBOutlet private weak var aegLayerView: CAEAGLLayerView!

  private static func configureAeglLayer(_ aeglLayer: CAEAGLLayer) {
    aeglLayer.cornerRadius = 5
    aeglLayer.borderWidth = 1
    aeglLayer.borderColor = #colorLiteral(red: 0.156, green: 0.156, blue: 0.156, alpha: 1)
  }
}
