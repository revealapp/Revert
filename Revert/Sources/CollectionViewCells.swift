//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

class CollectionViewCell: UICollectionViewCell {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.applyDynamicType(_:)), name:
      UIContentSizeCategoryDidChangeNotification, object: nil)
  }

  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    self.applyDynamicType()
  }

  func applyDynamicType(notification: NSNotification? = nil) {
    self.titleLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    self.subheadLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
  }

  // MARK: Private

  @IBOutlet private(set) weak var titleLabel: UILabel!
  @IBOutlet private(set) weak var subheadLabel: UILabel!
}

class TextFieldControlCell: CollectionViewCell {
  @IBOutlet private weak var textField: UITextField!

  @IBAction private func textFieldDidEndOnExit(sender: UITextField) {
    sender.resignFirstResponder()
  }
}

final class TextFieldControlCustomInputCell: TextFieldControlCell, UIPickerViewDelegate {
  override func awakeFromNib() {
    super.awakeFromNib()

    self.textField.inputView = self.textFieldInputView
    self.textField.inputAccessoryView = self.textFieldInputAccessoryView
  }

  func doneButtonTapped(sender: UIBarButtonItem) {
    self.textField.resignFirstResponder()
  }

  func datePickerChanged(datePicker: UIDatePicker) {
    self.textField.text = Static.DateFormatter.ddmmyy.stringFromDate(datePicker.date)
  }

  // MARK: Private

  private var textFieldInputView: UIDatePicker {
    let picker = UIDatePicker()
    picker.datePickerMode = .Date
    picker.addTarget(self, action: #selector(self.datePickerChanged(_:)), forControlEvents: .ValueChanged)
    picker.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
    return picker
  }

  private var textFieldInputAccessoryView: UIView {
    let size = CGSize(width: UIScreen.mainScreen().bounds.size.width, height: 44)
    let toolBar = UIToolbar(frame: CGRect(origin: CGPointZero, size: size))
    let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(self.doneButtonTapped(_:)))
    let flexibleBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)

    doneBarButtonItem.tintColor = UIColor.revertTintColor()
    toolBar.items = [
      flexibleBarButtonItem,
      doneBarButtonItem
    ]
    return toolBar
  }
}
