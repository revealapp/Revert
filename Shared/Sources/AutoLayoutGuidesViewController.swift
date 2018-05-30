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

    let sideMargin: CGFloat
    #if os(iOS)
      sideMargin = 0
    #else
      sideMargin = 60
    #endif

    NSLayoutConstraint.activate([
      self.topLeftView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: sideMargin),
      self.topRightView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -sideMargin),
      self.bottomLeftView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor, constant: sideMargin),
      self.bottomRightView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor, constant: -sideMargin),

      self.topLabel.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
      self.topLabel.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
      self.topLabel.bottomAnchor.constraint(equalTo: customLayoutGuide.topAnchor),

      self.bottomLabel.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
      self.bottomLabel.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
      self.bottomLabel.topAnchor.constraint(equalTo: customLayoutGuide.bottomAnchor)
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
      embeddedView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
    ])

    // Add tvOS-specific guides and constraints
    #if os(tvOS)
      AutoLayoutGuidesViewController.customFocusGuide(withFocusedView: embeddedViewController.centerView, addedTo: self.view, between: self.view.leftAnchor, and: readableContentGuide.leftAnchor)
      AutoLayoutGuidesViewController.customFocusGuide(withFocusedView: self.focusableView, addedTo: self.view, between: readableContentGuide.rightAnchor, and: self.view.rightAnchor)

      NSLayoutConstraint.activate([
        self.bottomLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.focusableImageView.focusedFrameGuide.topAnchor, constant: -8)
      ])
    #endif
  }

  // MARK: - Private

  @IBOutlet private var topLeftView: UIView!
  @IBOutlet private var topRightView: UIView!
  @IBOutlet private var bottomLeftView: UIView!
  @IBOutlet private var bottomRightView: UIView!
  @IBOutlet private var topLabel: UILabel!
  @IBOutlet private var bottomLabel: UILabel!

  #if os(tvOS)
    @IBOutlet private var focusableView: UIView!
    @IBOutlet private var focusableImageView: UIImageView!
  #endif

  @discardableResult
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

  @discardableResult
  private static func customFocusGuide(withFocusedView focusedView: UIView, addedTo view: UIView, between leftAnchor: NSLayoutXAxisAnchor, and rightAnchor: NSLayoutXAxisAnchor) -> UIFocusGuide {
    let guide = UIFocusGuide()
    view.addLayoutGuide(guide)

    if #available(iOS 10.0, tvOS 10.0, *) {
      guide.preferredFocusEnvironments = [focusedView]
    } else {
      guide.preferredFocusedView = focusedView
    }

    NSLayoutConstraint.activate([
      guide.topAnchor.constraint(equalTo: view.topAnchor),
      guide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      guide.leftAnchor.constraint(equalTo: leftAnchor),
      guide.rightAnchor.constraint(equalTo: rightAnchor)
    ])

    return guide
  }

  // MARK: - Manually embedded view controller

  private final class EmbeddedViewController: UIViewController {
    var centerView: UIView!

    override func viewDidLoad() {
      super.viewDidLoad()

      #if os(iOS)
        let centerView = CustomIntrinsicContentSizeView()
      #else
        let centerView = FocusableView()
      #endif

      centerView.backgroundColor = .vividGreen
      centerView.layer.cornerRadius = 2
      centerView.translatesAutoresizingMaskIntoConstraints = false
      self.view.addSubview(centerView)
      self.centerView = centerView

      NSLayoutConstraint.activate([
        centerView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor),
        centerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        centerView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
      ])

      #if os(iOS)
        NSLayoutConstraint.activate([
          centerView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 8)
        ])
      #else
        NSLayoutConstraint.activate([
          centerView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 60),
          centerView.widthAnchor.constraint(equalToConstant: 300),
          centerView.heightAnchor.constraint(equalTo: centerView.widthAnchor)
        ])
      #endif
    }
  }
}

// MARK: - Focusable view (tvOS)

@available(tvOS 9.0, iOS 9.0, *)
final class FocusableView: UIView {
  override var canBecomeFocused: Bool {
    return true
  }

  override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
    coordinator.addCoordinatedAnimations({
      self.alpha = self.isFocused ? 0.5 : 1.0
    })
  }
}
