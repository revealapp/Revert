//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class AutoResizingMaskViewController: RevertViewController {
  @IBOutlet private weak var outterView: UIView!
  
  private var viewsReady = false
  
  private func addSubViewsIfNeeded() {
    // Only perform this action once
    if self.viewsReady {
      return
    }
    self.viewsReady = true

    let viewSource = AutoResizingMaskViewSource(bounds: self.outterView.bounds)

    self.outterView.addSubview(viewSource.flexibleWidthHeightView)
    viewSource.flexibleWidthHeightView.addSubview(viewSource.flexibleWidthView)
    viewSource.flexibleWidthHeightView.addSubview(viewSource.flexibleHeightLeftRightView)
    
    // Left: Flexible Top / Bottom View
    viewSource.flexibleWidthHeightView.addSubview(viewSource.leftFlexibleTopBottomView)
    
    // Right: Flexible Top / Bottom View
    viewSource.flexibleWidthHeightView.addSubview(viewSource.rightFlexibleTopBottomView)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    self.addSubViewsIfNeeded()
  }
}
