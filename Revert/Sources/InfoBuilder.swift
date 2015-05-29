//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import Foundation

private func contentOfFile(filename: String) -> String {
  let path = NSBundle.mainBundle().pathForResource(filename, ofType: "html")
  assert(path != nil, "Cannot find file \(filename)")
  
  var error: NSError?
  let string = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: &error)
  assert(error == nil && string != nil, "Cannot load \(filename)")
  
  return string!
}

func HTMLWithContent(filename: String) -> String {
  let contentHTML = contentOfFile(filename)
  let containerHTML = contentOfFile("container")
  
  return containerHTML.stringByReplacingOccurrencesOfString("<REPLACE>", withString: contentHTML, options: .allZeros)
}

