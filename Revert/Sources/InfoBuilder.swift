//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

private func contentOfFile(_ filename: String) -> String {
  guard let path = Bundle.main.path(forResource: filename, ofType: "html") else {
    fatalError("Cannot find file \(filename)")
  }

  var error: NSError?
  let content: String?

  do {
    content = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
  } catch let error1 as NSError {
    error = error1
    content = nil
  }

  guard let unwrappedContent = content else {
    fatalError("Cannot load \(filename): \(String(describing: error))")
  }

  return unwrappedContent
}

func infoHTMLWithContent(_ filename: String) -> String {
  let contentHTML = contentOfFile("Info/\(filename)")
  let containerHTML = contentOfFile("Info/container")

  return containerHTML.replacingOccurrences(of: "<REPLACE>", with: contentHTML, options: [])
}
