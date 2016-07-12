//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

private func contentOfFile(filename: String) -> String {
  guard let path = NSBundle.mainBundle().pathForResource(filename, ofType: "html") else {
    fatalError("Cannot find file \(filename)")
  }

  var error: NSError?
  let content: String?

  do {
    content = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
  } catch let error1 as NSError {
    error = error1
    content = nil
  }

  guard let unwrappedContent = content else {
    fatalError("Cannot load \(filename): \(error)")
  }

  return unwrappedContent
}

func infoHTMLWithContent(filename: String) -> String {
  let contentHTML = contentOfFile("Info/\(filename)")
  let containerHTML = contentOfFile("Info/container")

  return containerHTML.stringByReplacingOccurrencesOfString("<REPLACE>", withString: contentHTML, options: [])
}
