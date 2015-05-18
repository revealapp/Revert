//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class PickerViewController: RevertViewController {
  private let collection = CollectableCollection<Country>(resourceFilename: "CountriesCapitals")
  
  @IBOutlet weak var pickerHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var containerView: UIView!
  
  private static let minimumSpacingHeight: CGFloat = 5 * 3
  private static let maxPickerHeight: CGFloat = 200
  
  private var pickerHeight: CGFloat {
    let pickersHeight = (self.containerView.bounds.height - self.dynamicType.minimumSpacingHeight) / 2
    return min(pickersHeight, self.dynamicType.maxPickerHeight)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    self.pickerHeightConstraint.constant = self.pickerHeight
  }
}


// MARK: UIPickerViewDataSource
extension PickerViewController: UIPickerViewDataSource {
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return self.collection[component].countOfRows
  }
}

// MARK: UIPickerViewDelegate
extension PickerViewController: UIPickerViewDelegate {
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    return self.collection.groups.first![row].name
  }
}
