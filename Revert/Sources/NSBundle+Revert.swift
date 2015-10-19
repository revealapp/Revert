//
//  Revert.swift
//  Revert
//
//  Created by Ben Thomas on 19/10/2015.
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

extension NSBundle {
  class var revealWebsiteURL: NSURL {

    if let urlString = NSBundle.mainBundle().infoDictionary!["revealWebsiteURL"] as? String,
      url = NSURL(string: urlString) {
        return url
    }

    preconditionFailure("reveal website URL missing or invalid")
  }
}