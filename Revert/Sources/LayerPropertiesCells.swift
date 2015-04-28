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
    textLayer.string = "I am a CATextLayer string. I'm quite long and wordy."
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
    
    self.dynamicType.configureTextLayer(self.emitterLayerView.emitterLayer)
  }
  
  private class func configureTextLayer(emitterLayer: CAEmitterLayer) {
    emitterLayer.emitterCells = [self.emitterCell]
    emitterLayer.birthRate = 100.0
    emitterLayer.emitterSize = CGSize(width: 1.0, height: 1.0)
    emitterLayer.emitterDepth = 1.9
    emitterLayer.emitterShape = kCAEmitterLayerPoint
    emitterLayer.emitterMode = kCAEmitterLayerPoints
    emitterLayer.renderMode = kCAEmitterLayerAdditive
    emitterLayer.preservesDepth = true
    emitterLayer.velocity = 1.5
    emitterLayer.scale = 1.1
    emitterLayer.spin = 2.1
    emitterLayer.seed = 424242
  }
  
  private static var emitterCell: CAEmitterCell {
    let emitterCell = CAEmitterCell()
    emitterCell.birthRate = 7000
    emitterCell.lifetime = 3.5
    emitterCell.color = UIColor.redColor().CGColor
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
    shapeLayer.path = UIBezierPath(rect: CGRect(x: 5.0, y: 5.0, width: 30.0, height: 30.0)).CGPath
    shapeLayer.fillColor = UIColor.magentaColor().CGColor
    shapeLayer.strokeColor = UIColor.yellowColor().CGColor
    shapeLayer.strokeStart = 0.2
    shapeLayer.strokeEnd = 0.8
    shapeLayer.fillRule = kCAFillRuleEvenOdd
    shapeLayer.lineWidth = 3.0
    shapeLayer.miterLimit = 5.0
    shapeLayer.lineCap = kCALineCapRound
    shapeLayer.lineJoin = kCALineCapRound
    shapeLayer.lineDashPhase = 2.0
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



