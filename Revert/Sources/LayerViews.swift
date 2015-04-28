//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class CATextLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CATextLayer.self
  }
  
  var textLayer: CATextLayer {
    return self.layer as! CATextLayer
  }
}

class CAScrollLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CAScrollLayer.self
  }
  
  var scrollLayer: CAScrollLayer {
    return self.layer as! CAScrollLayer
  }
}

class CAEmitterLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CAEmitterLayer.self
  }
  
  var emitterLayer: CAEmitterLayer {
    return self.layer as! CAEmitterLayer
  }
}

class CAShapeLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CAShapeLayer.self
  }
  
  var shapeLayer: CAShapeLayer {
    return self.layer as! CAShapeLayer
  }
}

class CATiledLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CATiledLayer.self
  }
  
  var tiledLayer: CATiledLayer {
    return self.layer as! CATiledLayer
  }
}

class CAGradientLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CAGradientLayer.self
  }
  
  var gradientLayer: CAGradientLayer {
    return self.layer as! CAGradientLayer
  }
}

class CAReplicatorLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CAReplicatorLayer.self
  }
  
  var replicatorLayer: CAReplicatorLayer {
    return self.layer as! CAReplicatorLayer
  }
}

class CAEAGLLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CAEAGLLayer.self
  }
  
  var aeglLayer: CAEAGLLayer {
    return self.layer as! CAEAGLLayer
  }
}
