//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class CATextLayerCell: UICollectionViewCell {
  
  @IBOutlet weak var textLayerView: CATextLayerView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.dynamicType.configureTextLayer(self.textLayerView.textLayer)
  }
  
  private class func configureTextLayer(textLayer: CATextLayer) {
    textLayer.string = "I am a quite long and wordy CATextLayer string."
    textLayer.fontSize = 20.0
    textLayer.foregroundColor = UIColor.lightGrayColor().CGColor
    textLayer.alignmentMode = kCAAlignmentCenter
    textLayer.truncationMode = kCATruncationMiddle
    textLayer.wrapped = true
  }
}

class CAEmitterLayerCell: UICollectionViewCell {
  
  @IBOutlet weak var emitterLayerView: CAEmitterLayerView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.dynamicType.configureEmitterLayer(self.emitterLayerView.emitterLayer)
  }
  
  private class func configureEmitterLayer(emitterLayer: CAEmitterLayer) {
    emitterLayer.emitterPosition = CGPoint(x: emitterLayer.bounds.midX, y: emitterLayer.bounds.midY)
    emitterLayer.emitterZPosition = 5.0
    emitterLayer.emitterSize = CGSize(width: 1.0, height: 1.0)
    emitterLayer.emitterShape = kCAEmitterLayerSphere
    emitterLayer.emitterDepth = 1.9
    emitterLayer.emitterShape = kCAEmitterLayerPoint
    emitterLayer.emitterMode = kCAEmitterLayerPoints
    emitterLayer.renderMode = kCAEmitterLayerAdditive
    emitterLayer.emitterCells = [self.emitterCell]
  }
  
  private static var emitterCell: CAEmitterCell {
    let emitterCell = CAEmitterCell()
    emitterCell.scale = 0.05
    emitterCell.scaleRange = 0.02
    emitterCell.emissionRange = CGFloat(2 * M_PI)
    emitterCell.lifetime = 10
    emitterCell.birthRate = 5
    emitterCell.velocity = 50
    emitterCell.velocityRange = 20
    emitterCell.yAcceleration = 250
    emitterCell.contents = UIImage(named: "spritekit_reveal")!.CGImage
    return emitterCell
  }
}

class CAShapeLayerCell: UICollectionViewCell {
  
  @IBOutlet weak var shapeLayerView: CAShapeLayerView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.dynamicType.configureShapeLayer(self.shapeLayerView.shapeLayer)
  }
  
  private class func configureShapeLayer(shapeLayer: CAShapeLayer) {
    let bezierPath = UIBezierPath(ovalInRect: shapeLayer.frame)
    shapeLayer.path = bezierPath.CGPath
    shapeLayer.fillColor = UIColor.revertOrangeColor().CGColor
    shapeLayer.strokeColor = UIColor.revertLightBlackColor().CGColor
    shapeLayer.strokeStart = 0.0
    shapeLayer.strokeEnd = 1.0
    shapeLayer.fillRule = kCAFillRuleEvenOdd
    shapeLayer.lineWidth = 2.0
    shapeLayer.miterLimit = 5.0
    shapeLayer.lineCap = kCALineCapRound
    shapeLayer.lineJoin = kCALineCapRound
    shapeLayer.lineDashPhase = 1.0
    shapeLayer.lineDashPattern = [1, 3, 4, 2]
  }
}

class CAScrollLayerCell: UICollectionViewCell {
  
  @IBOutlet weak var scrollLayerView: CAScrollLayerView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.dynamicType.configureScrollLayer(self.scrollLayerView.scrollLayer)
  }
  
  private class func configureScrollLayer(scrollLayer: CAScrollLayer) {
    scrollLayer.scrollMode = kCAScrollHorizontally
  }
}

class CATiledLayerCell: UICollectionViewCell {
  
  @IBOutlet weak var tiledLayerView: CATiledLayerView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.dynamicType.configureTiledLayer(self.tiledLayerView.tiledLayer)
  }
  
  private class func configureTiledLayer(tiledLayer: CATiledLayer) {
    tiledLayer.levelsOfDetail = 10
    tiledLayer.levelsOfDetailBias = 10
    tiledLayer.tileSize = CGSize(width: 512, height: 512)
  }
}

class CAGradientLayerCell: UICollectionViewCell {
  
  @IBOutlet weak var gradientLayerView: CAGradientLayerView!

  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.dynamicType.configureGradientLayer(self.gradientLayerView.gradientLayer)
  }
  
  private class func configureGradientLayer(gradientLayer: CAGradientLayer) {
    gradientLayer.type = kCAGradientLayerAxial
    gradientLayer.locations = [0.0, 0.5, 1.0]
    gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.2)
    gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.8)
    gradientLayer.cornerRadius = 5.0
    gradientLayer.borderWidth = 2.0
    gradientLayer.borderColor = UIColor.revertLightBlackColor().CGColor
    gradientLayer.colors = [
      UIColor.blackColor().CGColor,
      UIColor.redColor().CGColor,
      UIColor.whiteColor().CGColor
    ]
  }
}

class CAReplicatorLayerCell: UICollectionViewCell {
  
  @IBOutlet weak var replicatorLayerView: CAReplicatorLayerView!

  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.dynamicType.configureReplicatorLayer(self.replicatorLayerView.replicatorLayer)
  }
  
  private class func configureReplicatorLayer(replicatorLayer: CAReplicatorLayer) {
    replicatorLayer.instanceCount = 5
    replicatorLayer.preservesDepth = true
    replicatorLayer.instanceDelay = 1.0
    replicatorLayer.instanceTransform = CATransform3DIdentity
    replicatorLayer.instanceColor = UIColor.redColor().CGColor
    replicatorLayer.instanceRedOffset = 0.2
    replicatorLayer.instanceGreenOffset = 0.3
    replicatorLayer.instanceBlueOffset = 0.1
    replicatorLayer.instanceAlphaOffset = 0.2
  }
}

class CAEAGLLayerCell: UICollectionViewCell {
  
  @IBOutlet weak var aegLayerView: CAEAGLLayerView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    self.dynamicType.configureAeglLayer(self.aegLayerView.aeglLayer)
  }
  
  private class func configureAeglLayer(aeglLayer: CAEAGLLayer) {
    // TODO: Implement?
  }
}



