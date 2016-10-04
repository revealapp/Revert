//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class CATextLayerCell: CollectionViewCell {
  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureTextLayer(self.textLayerView.textLayer)
  }

  // MARK: Private

  @IBOutlet fileprivate weak var textLayerView: CATextLayerView!

  fileprivate static func configureTextLayer(_ textLayer: CATextLayer) {
    textLayer.string = NSLocalizedString("I am a quite long CATextLayer string.", comment: "")
    textLayer.fontSize = 20
    textLayer.foregroundColor = UIColor.lightGray.cgColor
    textLayer.alignmentMode = kCAAlignmentCenter
    textLayer.truncationMode = kCATruncationMiddle
    textLayer.isWrapped = true
  }
}

final class CAEmitterLayerCell: CollectionViewCell {
  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureEmitterLayer(self.emitterLayerView.emitterLayer)
  }

  // MARK: Private

  @IBOutlet fileprivate weak var emitterLayerView: CAEmitterLayerView!

  fileprivate static func configureEmitterLayer(_ emitterLayer: CAEmitterLayer) {
    emitterLayer.emitterPosition = CGPoint(x: emitterLayer.bounds.midX, y: emitterLayer.bounds.midY)
    emitterLayer.emitterZPosition = 5
    emitterLayer.emitterSize = CGSize(width: 1, height: 1)
    emitterLayer.emitterShape = kCAEmitterLayerSphere
    emitterLayer.emitterDepth = 1.9
    emitterLayer.emitterShape = kCAEmitterLayerPoint
    emitterLayer.emitterMode = kCAEmitterLayerPoints
    emitterLayer.renderMode = kCAEmitterLayerAdditive
    emitterLayer.emitterCells = [self.emitterCell]
  }

  fileprivate static var emitterCell: CAEmitterCell {
    let emitterCell = CAEmitterCell()
    emitterCell.scale = 0.05
    emitterCell.scaleRange = 0.02
    emitterCell.emissionRange = CGFloat(2 * M_PI)
    emitterCell.lifetime = 10
    emitterCell.birthRate = 5
    emitterCell.velocity = 50
    emitterCell.velocityRange = 20
    emitterCell.yAcceleration = 250
    emitterCell.contents = UIImage(named: "spritekit_reveal")!.cgImage
    return emitterCell
  }
}

final class CAShapeLayerCell: CollectionViewCell {
  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureShapeLayer(self.shapeLayerView.shapeLayer)
  }


  // MARK: Private

  @IBOutlet fileprivate weak var shapeLayerView: CAShapeLayerView!

  fileprivate static func configureShapeLayer(_ shapeLayer: CAShapeLayer) {
    let minLength = min(shapeLayer.frame.height, shapeLayer.frame.width)
    let origin = CGPoint(x: (shapeLayer.bounds.width - minLength) / 2, y: 0)
    let rect = CGRect(origin: origin, size: CGSize(width: minLength, height: minLength))
    shapeLayer.path = UIBezierPath(ovalIn: rect).cgPath
    shapeLayer.fillColor = UIColor.revertOrangeColor().cgColor
    shapeLayer.strokeColor = UIColor.revertLightBlackColor().cgColor
    shapeLayer.strokeStart = 0
    shapeLayer.strokeEnd = 1
    shapeLayer.fillRule = kCAFillRuleEvenOdd
    shapeLayer.lineWidth = 2
    shapeLayer.miterLimit = 5
    shapeLayer.lineCap = kCALineCapRound
    shapeLayer.lineJoin = kCALineCapRound
    shapeLayer.lineDashPhase = 1
    shapeLayer.lineDashPattern = [1, 3, 4, 2]
  }
}

final class CAScrollLayerCell: CollectionViewCell {
  @IBOutlet fileprivate weak var scrollLayerView: CAScrollLayerView!

  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureScrollLayer(self.scrollLayerView.scrollLayer)
  }

  fileprivate static func configureScrollLayer(_ scrollLayer: CAScrollLayer) {
    scrollLayer.scrollMode = kCAScrollHorizontally
    scrollLayer.backgroundColor = UIColor.revertDarkblueColor().cgColor
    scrollLayer.cornerRadius = 5
  }
}

final class CATiledLayerCell: CollectionViewCell {
  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureTiledLayer(self.tiledLayerView.tiledLayer)
  }

  // MARK: Private

  @IBOutlet fileprivate weak var tiledLayerView: CATiledLayerView!

  fileprivate static func configureTiledLayer(_ tiledLayer: CATiledLayer) {
    tiledLayer.levelsOfDetail = 10
    tiledLayer.levelsOfDetailBias = 10
    tiledLayer.tileSize = tiledLayer.bounds.size
    tiledLayer.cornerRadius = 5
    tiledLayer.borderWidth = 1
    tiledLayer.borderColor = UIColor.revertLightBlackColor().cgColor
  }
}

final class CAGradientLayerCell: CollectionViewCell {
  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureGradientLayer(self.gradientLayerView.gradientLayer)
  }

  // MARK: Private

  @IBOutlet fileprivate weak var gradientLayerView: CAGradientLayerView!

  fileprivate static func configureGradientLayer(_ gradientLayer: CAGradientLayer) {
    gradientLayer.type = kCAGradientLayerAxial
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

final class CAReplicatorLayerCell: CollectionViewCell {
  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureReplicatorLayer(self.replicatorLayerView.replicatorLayer)
  }

  // MARK: Private

  @IBOutlet fileprivate weak var replicatorLayerView: CAReplicatorLayerView!

  fileprivate static func configureReplicatorLayer(_ replicatorLayer: CAReplicatorLayer) {
    let circleWidth: CGFloat = 20
    let circlePadding: CGFloat = 10
    let circleRect = CGRect(x: circlePadding / 2, y: replicatorLayer.bounds.midY - circleWidth / 2, width: circleWidth, height: circleWidth)
    let circleLayer = CAShapeLayer()

    circleLayer.path = UIBezierPath(ovalIn: circleRect).cgPath
    circleLayer.fillColor = UIColor.revertOrangeColor().cgColor

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

final class CAEAGLLayerCell: CollectionViewCell {
  override func awakeFromNib() {
    super.awakeFromNib()

    type(of: self).configureAeglLayer(self.aegLayerView.aeglLayer)
  }

  // MARK: Private

  @IBOutlet fileprivate weak var aegLayerView: CAEAGLLayerView!

  fileprivate static func configureAeglLayer(_ aeglLayer: CAEAGLLayer) {
    aeglLayer.cornerRadius = 5
    aeglLayer.borderWidth = 1
    aeglLayer.borderColor = UIColor.revertLightBlackColor().cgColor
  }
}
