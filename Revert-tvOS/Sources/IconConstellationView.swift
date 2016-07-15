//
//  Copyright © 2016 Itty Bitty Apps. All rights reserved.
//

import UIKit

class IconConstellationView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

  var animatedIcons: [UIImage] = [] {
    didSet {
      self.iconGrid.reloadData()
    }
  }

  var iconSize = 100.0 as CGFloat {
    didSet {
      self.iconGridLayout.itemSize = CGSize(width: self.iconSize, height: self.iconSize)
    }
  }

  var iconSpacing = 26.0 as CGFloat {
    didSet {
      self.iconGridLayout.minimumLineSpacing = self.iconSpacing
      self.iconGridLayout.minimumInteritemSpacing = self.iconSpacing
    }
  }

  private var iconGrid: UICollectionView!
  private var iconGridLayout: UICollectionViewFlowLayout {
    return self.iconGrid.collectionViewLayout as! UICollectionViewFlowLayout
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.commonInit()
  }

  private func commonInit() {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .Vertical
    layout.itemSize = CGSizeMake(self.iconSize, self.iconSize)
    layout.minimumLineSpacing = self.iconSpacing
    layout.minimumInteritemSpacing = self.iconSpacing

    let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.userInteractionEnabled = false
    collectionView.scrollEnabled = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.clipsToBounds = false
    collectionView.registerClass(IconConstellationViewCell.self, forCellWithReuseIdentifier: Constants.cellReuseIdentifier)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(collectionView)

    NSLayoutConstraint.activateConstraints([
      self.topAnchor.constraintEqualToAnchor(collectionView.topAnchor),
      self.bottomAnchor.constraintEqualToAnchor(collectionView.bottomAnchor),
      self.leadingAnchor.constraintEqualToAnchor(collectionView.leadingAnchor),
      self.trailingAnchor.constraintEqualToAnchor(collectionView.trailingAnchor)
      ])

    self.iconGrid = collectionView
  }

  var animating = false {
    didSet {
      if self.animating != oldValue && self.window != nil {
        if self.animating {
          self.startAnimatingVisibleCells()
        } else {
          self.stopAnimatingVisibleCells()
        }
      }
    }
  }

  override func didMoveToWindow() {
    super.didMoveToWindow()

    if self.window != nil && self.animating {
      self.startAnimatingVisibleCells()
    }
  }

  private func startAnimatingVisibleCells() {
    for case let cell as IconConstellationViewCell in self.iconGrid.visibleCells() {
      cell.startAnimatingWithRandomParameters()
    }
  }

  private func stopAnimatingVisibleCells() {
    for case let cell as IconConstellationViewCell in self.iconGrid.visibleCells() {
      cell.stopAnimating()
    }
  }

  // MARK: UICollectionViewDataSource

  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.animatedIcons.count
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Constants.cellReuseIdentifier, forIndexPath: indexPath) as! IconConstellationViewCell
    cell.icon = self.animatedIcons[indexPath.row]

    return cell
  }

  // MARK: UICollectionViewDelegate

  func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    if self.animating {
      (cell as? IconConstellationViewCell)?.startAnimatingWithRandomParameters()
    }
  }

  func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    (cell as? IconConstellationViewCell)?.stopAnimating()
  }

  // MARK: Constants

  private struct Constants {
    static let cellReuseIdentifier = String(IconConstellationViewCell.self)
  }

}

// MARK: - Cell class

private class IconConstellationViewCell: UICollectionViewCell {

  var icon: UIImage? {
    get {
      return self.iconView.image
    }
    set {
      self.iconView.image = newValue
    }
  }

  private var iconView: UIImageView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.commonInit()
  }

  private func commonInit() {
    let iconView = UIImageView(frame: self.bounds)
    iconView.contentMode = .Center
    iconView.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(iconView)

    NSLayoutConstraint.activateConstraints([
      self.topAnchor.constraintEqualToAnchor(iconView.topAnchor),
      self.bottomAnchor.constraintEqualToAnchor(iconView.bottomAnchor),
      self.leadingAnchor.constraintEqualToAnchor(iconView.leadingAnchor),
      self.trailingAnchor.constraintEqualToAnchor(iconView.trailingAnchor)
    ])

    self.iconView = iconView
  }

  private override func prepareForReuse() {
    super.prepareForReuse()

    self.stopAnimating()
  }

  /// This is a workaround for a performance issue in UICollectionView with non-dynamic item sizes
  /// See http://www.openradar.appspot.com/26887172
  override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    return layoutAttributes
  }

  // MARK: Animation

  func startAnimating(withDuration duration: NSTimeInterval, initialPhase: Double) {
    let animation = CABasicAnimation(keyPath: "opacity")
    animation.duration = duration
    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    animation.fromValue = 1.0 as NSNumber
    animation.toValue = 0.3 as NSNumber
    animation.autoreverses = true
    animation.repeatCount = FLT_MAX
    animation.timeOffset = duration * initialPhase * 2.0

    self.iconView.layer.addAnimation(animation, forKey: Constants.animationKey)
  }

  func startAnimatingWithRandomParameters() {
    self.startAnimating(withDuration: Double.random(between: 1.0, and: 4.0),
                        initialPhase: Double.random(between: 0.0, and: 1.0))
  }

  func stopAnimating() {
    self.iconView.layer.removeAnimationForKey(Constants.animationKey)
  }

  // MARK: Constants

  private struct Constants {
    static let animationKey = "twinkle"
  }

}
