//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class PickerViewController: RevertViewController {

  @IBOutlet var inlineDatePicker: UIDatePicker!
  @IBOutlet var wheelDatePicker: UIDatePicker!

  @IBOutlet var iOS14Container: UIView!
  @IBOutlet var normalContainer: UIView!

  override func loadView() {
    super.loadView()

    if #available(iOS 14.0, *) {
      self.view = iOS14Container
      inlineDatePicker.preferredDatePickerStyle = .inline
      wheelDatePicker.preferredDatePickerStyle = .wheels
    } else {
      self.view = normalContainer
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
