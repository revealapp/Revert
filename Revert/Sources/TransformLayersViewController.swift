//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class TransformLayersViewController: UIViewController {
  @IBOutlet weak var yRotateView: UIView!
  @IBOutlet weak var xRotateView: UIView!
  
  @IBOutlet weak var bottomView: UIView!
  
  @IBOutlet weak var cubeFrontView: UIView!
  @IBOutlet weak var cubeRightView: UIView!
  @IBOutlet weak var cubeTopView: UIView!
  
  private var sideLength: CGFloat {
    return self.cubeFrontView.bounds.width
  }
  
  private func degreesToRadians(degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat(M_PI) / 180.0
  }
  
  private func transformCube() {
    let ninetyDegreesInRadian = self.degreesToRadians(90.0)
    let fortyFiveDegreesInRadian = self.degreesToRadians(30.0)
    let halfSideLength = self.sideLength / 2.0
    
    var rightTransform = CATransform3DMakeTranslation(halfSideLength, 0.0, halfSideLength)
    rightTransform = CATransform3DRotate(rightTransform, ninetyDegreesInRadian, 0.0, 1.0, 0.0)
    self.cubeRightView.layer.transform = rightTransform
    
    var topTransform = CATransform3DMakeTranslation(0.0, -halfSideLength, -halfSideLength)
    topTransform = CATransform3DRotate(topTransform, ninetyDegreesInRadian, 1.0, 0.0, 0.0)
    self.cubeTopView.layer.transform = topTransform
    
    var frontTransform = CATransform3DMakeTranslation(0.0, 0.0, -self.sideLength)
    self.cubeFrontView.layer.transform = frontTransform
    
    self.bottomView.layer.transform = CATransform3DMakeRotation(-fortyFiveDegreesInRadian, 0.0, 1.0, 0.0)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.transformCube()
  }
}
