//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class PickerViewController: RevertViewController {
  fileprivate let collection = CollectableCollection<Country>(items: .capitalCities)
}

// MARK: - UIPickerViewDataSource
extension PickerViewController: UIPickerViewDataSource {

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return self.collection[component].countOfItems
  }
}

// MARK: - UIPickerViewDelegate
extension PickerViewController: UIPickerViewDelegate {

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return self.collection.items.first?[row].name
  }
}
