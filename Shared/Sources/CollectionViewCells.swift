//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

class CollectionViewCell: UICollectionViewCell {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    NotificationCenter.default.addObserver(self, selector: #selector(self.applyDynamicType(_:)), name:
      NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
  }

  deinit {
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIContentSizeCategoryDidChange, object: nil)
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    self.applyDynamicType()
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    guard #available(tvOS 10.0, *) else { return }
    if self.traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
      self.configureTitleLabelTextColor()
    }
  }

  func applyDynamicType(_ notification: Notification? = nil) {
    self.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
    self.subheadLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)
  }

  // MARK: Private

  @IBOutlet fileprivate(set) weak var titleLabel: UILabel!
  @IBOutlet private(set) weak var subheadLabel: UILabel!

  fileprivate func configureTitleLabelTextColor() {
    if self.isFocused {
      self.titleLabel.textColor = UIColor.white
    } else {
      guard #available(tvOS 10.0, *) else {
        self.titleLabel.textColor = UIColor.black
        return
      }

      switch self.traitCollection.userInterfaceStyle {
      case .dark:
        self.titleLabel.textColor = UIColor.lightGray
      case .light, .unspecified:
        self.titleLabel.textColor = UIColor.black
      }
    }
  }
}

class TextFieldControlCell: CollectionViewCell {
  @IBOutlet fileprivate weak var textField: UITextField!

  @IBAction private func textFieldDidEndOnExit(_ sender: UITextField) {
    sender.resignFirstResponder()
  }
}

#if os(iOS)

  final class TextFieldControlCustomInputCell: TextFieldControlCell, UIPickerViewDelegate {

    override func awakeFromNib() {
      super.awakeFromNib()

      self.textField.inputView = self.textFieldInputView
      self.textField.inputAccessoryView = self.textFieldInputAccessoryView
    }

    func doneButtonTapped(_ sender: UIBarButtonItem) {
      self.textField.resignFirstResponder()
    }

    func datePickerChanged(_ datePicker: UIDatePicker) {
      self.textField.text = Static.Formatter.ddmmyy.string(from: datePicker.date)
    }

    // MARK: Private

    private var textFieldInputView: UIDatePicker {
      let picker = UIDatePicker()
      picker.datePickerMode = .date
      picker.addTarget(self, action: #selector(self.datePickerChanged(_:)), for: .valueChanged)
      picker.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      return picker
    }

    private var textFieldInputAccessoryView: UIView {
      let size = CGSize(width: UIScreen.main.bounds.size.width, height: 44)
      let toolBar = UIToolbar(frame: CGRect(origin: .zero, size: size))
      let doneBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: "Done alert title"), style: .done, target: self, action: #selector(self.doneButtonTapped(_:)))
      let flexibleBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

      doneBarButtonItem.tintColor = UIColor.revertTintColor()
      toolBar.items = [
        flexibleBarButtonItem,
        doneBarButtonItem,
      ]
      return toolBar
    }
  }
#endif

#if os(tvOS)

  final class HomeCollectionCell: CollectionViewCell {

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
      super.didUpdateFocus(in: context, with: coordinator)

      coordinator.addCoordinatedAnimations({
        self.configureTitleLabelTextColor()
        }, completion: nil)
    }

    // MARK: Private

    @IBOutlet private(set) weak var imageView: UIImageView!

  }
#endif
