//
//  Copyright © 2017 Itty Bitty Apps. All rights reserved.

import Foundation

@available(iOS 9.0, tvOS 9.0, *)
final class AutoLayoutGuidesViewController: RevertViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Manually creating constraints and guides as they're unavailable in IB
    let layoutMarginsGuide = self.view.layoutMarginsGuide
    let readableContentGuide = self.view.readableContentGuide
    let customLayoutGuide = AutoLayoutGuidesViewController.customLayoutGuide(addedTo: self.view)

    NSLayoutConstraint.activate([
      self.topLeftView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      self.topRightView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
      self.bottomLeftView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
      self.bottomRightView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),

      self.topLabel.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
      self.topLabel.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
      self.topLabel.bottomAnchor.constraint(equalTo: customLayoutGuide.topAnchor),

      self.bottomLabel.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
      self.bottomLabel.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
      self.bottomLabel.topAnchor.constraint(equalTo: customLayoutGuide.bottomAnchor),
    ])

    // Manually embedding a view controller so that its top/bottom layout guides are actual UILayoutGuide objects and not _UILayoutGuide views
    let embeddedViewController = EmbeddedViewController()
    let embeddedView = embeddedViewController.view!

    self.addChildViewController(embeddedViewController)
    embeddedView.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(embeddedView)
    embeddedViewController.didMove(toParentViewController: self)

    NSLayoutConstraint.activate([
      embeddedView.topAnchor.constraint(equalTo: self.view.topAnchor),
      embeddedView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      embeddedView.widthAnchor.constraint(equalToConstant: 128),
      embeddedView.heightAnchor.constraint(equalToConstant: 160),
    ])
  }

  // MARK: - Private

  @IBOutlet private weak var topLeftView: UIView!
  @IBOutlet private weak var topRightView: UIView!
  @IBOutlet private weak var bottomLeftView: UIView!
  @IBOutlet private weak var bottomRightView: UIView!
  @IBOutlet private weak var topLabel: UILabel!
  @IBOutlet private weak var bottomLabel: UILabel!

  private static func customLayoutGuide(addedTo view: UIView) -> UILayoutGuide {
    let guide = UILayoutGuide()
    view.addLayoutGuide(guide)

    NSLayoutConstraint.activate([
      guide.heightAnchor.constraint(equalToConstant: 50),
      guide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      guide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      guide.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])

    return guide
  }

  // MARK: - Manually embedded view controller

  final private class EmbeddedViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()

      let centerView = CustomIntrinsicContentSizeView()
      centerView.backgroundColor = UIColor.vividGreenColor()
      centerView.layer.cornerRadius = 2
      centerView.translatesAutoresizingMaskIntoConstraints = false
      self.view.addSubview(centerView)

      NSLayoutConstraint.activate([
        centerView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 8),
        centerView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: -8),
        centerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      ])
    }
    
  }

}
