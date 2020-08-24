//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class PickerViewController: RevertViewController {
  private let sections: [CountrySection] = RevertItems.capitalCities.newData()
}

// MARK: - UIPickerViewDataSource
extension PickerViewController: UIPickerViewDataSource {

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return sections[component].rows.count
  }
}

// MARK: - UIPickerViewDelegate
extension PickerViewController: UIPickerViewDelegate {

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return sections.first?.rows[row].name
  }
}
