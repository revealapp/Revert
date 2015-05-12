//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final internal class PickerViewController: UIViewController, SettableMasterItem {
  private let collection = CollectableCollection<Country>(resourceFilename: "CountriesCapitals")
  var item: MasterItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    assert(self.item != nil, "Item must be set before `viewDidLoad`")
  }
  
  @IBAction func infoButtonTapped(sender: UIBarButtonItem) {
    self.presentInfoViewControllerWithItem(self.item!)
  }
}

// MARK: UIPickerViewDataSource

extension PickerViewController: UIPickerViewDataSource {
  internal func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  internal func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return self.collection[component].countOfRows
  }
}

// MARK: UIPickerViewDelegate

extension PickerViewController: UIPickerViewDelegate {
  internal func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    return self.collection.groups.first![row].name
  }
}
