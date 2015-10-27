//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class CustomIntrinsicContentSizeView: UIView {
  override func intrinsicContentSize() -> CGSize {
    return CGSize(width: 80, height: 80)
  }
}
