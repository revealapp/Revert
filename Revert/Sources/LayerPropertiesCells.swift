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
}

class CAScrollLayerCell: UICollectionViewCell {
  
  @IBOutlet weak var scrollLayerView: CAScrollLayerView!
}

class CATiledLayerCell: UICollectionViewCell {
  
  @IBOutlet weak var tiledLayerView: CATiledLayerView!
}

class CAGradientLayerCell: UICollectionViewCell {
  
  @IBOutlet weak var gradientLayerView: CAGradientLayerView!
}

class CAReplicatorLayerCell: UICollectionViewCell {
  
  @IBOutlet weak var replicatorLayerView: CAReplicatorLayerView!
}

class CAEAGLLayerCell: UICollectionViewCell {
  
  @IBOutlet weak var aegLayerView: CAEAGLLayerView!
}



