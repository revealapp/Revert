//
//  Revert.swift
//  Revert
//
//  Created by Ben Thomas on 19/10/2015.
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

extension NSBundle {
  var revealWebsiteURL: NSURL {

    guard let urlString = infoDictionary!["revealWebsiteURL"] as? String,
      url = NSURL(string: urlString) else {
        preconditionFailure("reveal website URL missing or invalid")
    }

    return url
  }
}