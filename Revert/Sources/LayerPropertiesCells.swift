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



