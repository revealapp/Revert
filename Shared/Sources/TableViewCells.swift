//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class HomeCell: BasicCell {

  func updateSelectedBackgroundColor(_ isBlue: Bool) {
    if isBlue {
      let selectedBackgroundView = UIView()
      selectedBackgroundView.backgroundColor = UIColor.revertTintColor()
      self.selectedBackgroundView = selectedBackgroundView
    } else {
      self.selectedBackgroundView = nil
    }
  }

  // MARK: Private

  @IBOutlet private(set) weak var iconImageView: UIImageView!
}

class BasicCell: UITableViewCell {

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

  func applyDynamicType(_ notification: Notification? = nil) {
    self.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
    self.subtitleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote)
  }

  // MARK: Private

  @IBOutlet private(set) weak var titleLabel: UILabel!
  @IBOutlet private(set) weak var subtitleLabel: UILabel!

  #if os(tvOS)

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
      super.traitCollectionDidChange(previousTraitCollection)

      guard #available(tvOS 10.0, *) else { return }
      if self.traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
        self.configureTitleLabelTextColor()
      }
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
      super.didUpdateFocus(in: context, with: coordinator)

      coordinator.addCoordinatedAnimations({
        self.configureTitleLabelTextColor()
      }, completion: nil)
    }

    private func configureTitleLabelTextColor() {
      guard #available(tvOS 10.0, *) else {
        return
      }

      switch self.traitCollection.userInterfaceStyle {
      case .dark:
        if self.isFocused {
          self.titleLabel.textColor = .darkGray
        } else {
          self.titleLabel.textColor = .white
        }
      case .light, .unspecified:
        self.titleLabel.textColor = .black
      }
    }

  #endif
}
