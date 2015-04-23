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
  
  private var isFirstAppear = true
  
  private func degreesToRadians(degrees: CGFloat) -> CGFloat {
    return degrees * CGFloat(M_PI) / 180.0
  }
  
  private func buildCube() {
    let ninetyDegreesInRadian = self.degreesToRadians(90.0)
    let halfSideLength = self.sideLength / 2.0
    
    var rightTransform = CATransform3DMakeTranslation(halfSideLength, 0.0, halfSideLength)
    rightTransform = CATransform3DRotate(rightTransform, ninetyDegreesInRadian, 0.0, 1.0, 0.0)
    self.cubeRightView.layer.transform = rightTransform
    
    var topTransform = CATransform3DMakeTranslation(0.0, -halfSideLength, halfSideLength)
    topTransform = CATransform3DRotate(topTransform, ninetyDegreesInRadian, 1.0, 0.0, 0.0)
    self.cubeTopView.layer.transform = topTransform
    
    var frontTransform = CATransform3DMakeTranslation(0.0, 0.0, self.sideLength)
    self.cubeFrontView.layer.transform = frontTransform
  }
  
  private func animateIfNecessarry() {
    if self.isFirstAppear {
      self.isFirstAppear = false

      let fortyFiveDegreesInRadian = self.degreesToRadians(45.0)

      UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: {
        // Top Views
        self.xRotateView.layer.transform = CATransform3DMakeRotation(fortyFiveDegreesInRadian, 1.0, 0.0, 0.0)
        self.yRotateView.layer.transform = CATransform3DMakeRotation(fortyFiveDegreesInRadian, 0.0, 1.0, 0.0)

        // Cube
        self.bottomView.layer.transform = CATransform3DMakeRotation(-fortyFiveDegreesInRadian, 0.0, 1.0, 0.0)
      }, completion: nil)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
    self.buildCube()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
   
    self.animateIfNecessarry()
  }
}
