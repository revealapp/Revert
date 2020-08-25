//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class PickerViewController: RevertViewController {

  @IBOutlet var inlineDatePicker: UIDatePicker!

  override func viewDidLoad() {
    super.viewDidLoad()

    if #available(iOS 14.0, *) {
      inlineDatePicker.preferredDatePickerStyle = .inline
    }
  }
  private let sections: [CountrySection] = RevertItems.capitalCities.data()

}

// MARK: - UIPickerViewDataSource
extension PickerViewController: UIPickerViewDataSource {

  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return self.sections[component].rows.count
  }
}

// MARK: - UIPickerViewDelegate
extension PickerViewController: UIPickerViewDelegate {

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return self.sections.first?.rows[row].name
  }
}
