//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class CATextLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CATextLayer.self
  }

  var textLayer: CATextLayer {
    return self.layer as! CATextLayer
  }
}

final class CAScrollLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CAScrollLayer.self
  }

  var scrollLayer: CAScrollLayer {
    return self.layer as! CAScrollLayer
  }
}

final class CAEmitterLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CAEmitterLayer.self
  }

  var emitterLayer: CAEmitterLayer {
    return self.layer as! CAEmitterLayer
  }
}

final class CAShapeLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CAShapeLayer.self
  }

  var shapeLayer: CAShapeLayer {
    return self.layer as! CAShapeLayer
  }
}

final class CATiledLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CATiledLayer.self
  }

  var tiledLayer: CATiledLayer {
    return self.layer as! CATiledLayer
  }
}

final class CAGradientLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CAGradientLayer.self
  }

  var gradientLayer: CAGradientLayer {
    return self.layer as! CAGradientLayer
  }
}

final class CAReplicatorLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CAReplicatorLayer.self
  }

  var replicatorLayer: CAReplicatorLayer {
    return self.layer as! CAReplicatorLayer
  }
}

final class CAEAGLLayerView: UIView {
  override class func layerClass() -> AnyClass {
    return CAEAGLLayer.self
  }

  var aeglLayer: CAEAGLLayer {
    return self.layer as! CAEAGLLayer
  }
}
