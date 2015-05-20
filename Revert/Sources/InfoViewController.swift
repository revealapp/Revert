//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class InfoViewController: UIViewController, SettableHomeItem {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var titleLabel: UILabel!
  
  var item: HomeItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.textView.textContainerInset = UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 8)
    
    // Configure the view
    if let item = self.item {
      self.textView.text = item.info
      self.imageView.image = UIImage(named: item.iconName)
      self.titleLabel.text = item.title
    } else {
      fatalError("Item should be set before viewDidLoad")
    }
  }
  
  @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
    self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
  }
}