//
//  InfoViewController.swift
//  Revert
//
//  Created by Hugo Cuvillier on 11/05/2015.
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var titleLabel: UILabel!
  
  internal var item: MasterItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.textView.textContainerInset = UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 8)
    
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