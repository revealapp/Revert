//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import Foundation

enum RevertItems: String {
  case capitalCities = "CountriesCapitals"
  case alert = "AlertItems"
  case home = "HomeItems"
  case control = "ControlItems"
  case mapLocations = "MapLocations"
  case layerProperties = "LayerPropertiesItems"
  case view = "ViewItems"
  case whatsNew = "NewItems"

  var data: [[String: AnyObject]] {
    guard let data = NSArray(contentsOf: self.URL) as? [[String: AnyObject]] else {
      fatalError(self.invalidContentError)
    }
    return data
  }

  func newData<T: Decodable>() -> T {
    do {
      let data = try Data(contentsOf: self.URL)
      let decoder = PropertyListDecoder()
      let decodedData = try decoder.decode(T.self, from: data)

      return decodedData
    } catch {
      fatalError(invalidContentError)
    }
  }

  // MARK: Private

  private static let fileExtension = "plist"
  private static let subfolder = "Data"

  private var invalidContentError: String {
    return "Invalid content: \(self.rawValue).\(type(of: self).fileExtension)"
  }

  private var invalidFileError: String {
    return "Invalid file: No common or platform-specific \(self.rawValue) files exist"
  }

  private var URL: Foundation.URL {
    var URL: Foundation.URL? {
      let commonPath = "\(type(of: self).subfolder)/\(self.rawValue)"
      let platformPath = "\(commonPath)\(type(of: self).platformSuffix)"

      if let platformURL = Bundle.main.url(forResource: platformPath, withExtension: type(of: self).fileExtension) {
        return platformURL
      } else {
        let commonURL = Bundle.main.url(forResource: commonPath, withExtension: type(of: self).fileExtension)
        return commonURL
      }
    }

    guard let fileURL = URL else {
      fatalError(self.invalidFileError)
    }
    return fileURL
  }
}

extension RevertItems {
  #if os(iOS)
    fileprivate static let platformSuffix = "_iOS"
  #endif

  #if os(tvOS)
    fileprivate static let platformSuffix = "_tvOS"
  #endif
}

extension RevertItems {

  static var coloursData: [ColourSection] {
    if #available(iOS 13.0, *) {
      return [
        .init(title: "LABEL", rows: [
          .init(name: #keyPath(UIColor.label), color: .label),
          .init(name: #keyPath(UIColor.secondaryLabel), color: .secondaryLabel),
          .init(name: #keyPath(UIColor.tertiaryLabel), color: .tertiaryLabel),
          .init(name: #keyPath(UIColor.quaternaryLabel), color: .quaternaryLabel)
        ]),
        .init(title: "FILL", rows: [
          .init(name: #keyPath(UIColor.systemFill), color: .systemFill),
          .init(name: #keyPath(UIColor.secondarySystemFill), color: .secondarySystemFill),
          .init(name: #keyPath(UIColor.tertiarySystemFill), color: .tertiarySystemFill),
          .init(name: #keyPath(UIColor.quaternarySystemFill), color: .quaternarySystemFill)
        ]),
        .init(title: "TEXT", rows: [
          .init(name: #keyPath(UIColor.placeholderText), color: .placeholderText)
        ]),
        .init(title: "STANDARD CONTENT BACKGROUND", rows: [
          .init(name: #keyPath(UIColor.systemBackground), color: .systemBackground),
          .init(name: #keyPath(UIColor.secondarySystemBackground), color: .secondarySystemBackground),
          .init(name: #keyPath(UIColor.tertiarySystemBackground), color: .tertiarySystemBackground)
        ]),
        .init(title: "GROUPED CONTENT BACKGROUND", rows: [
          .init(name: #keyPath(UIColor.systemGroupedBackground), color: .systemGroupedBackground),
          .init(name: #keyPath(UIColor.secondarySystemGroupedBackground), color: .secondarySystemGroupedBackground),
          .init(name: #keyPath(UIColor.tertiarySystemGroupedBackground), color: .tertiarySystemGroupedBackground)
        ]),
        .init(title: "SEPARATOR", rows: [
          .init(name: #keyPath(UIColor.separator), color: .separator),
          .init(name: #keyPath(UIColor.opaqueSeparator), color: .opaqueSeparator)
        ]),
        .init(title: "LINK", rows: [
          .init(name: #keyPath(UIColor.link), color: .link)
        ]),
        .init(title: "ADAPTABLE", rows: [
          .init(name: #keyPath(UIColor.systemBlue), color: .systemBlue),
          .init(name: #keyPath(UIColor.systemGreen), color: .systemGreen),
          .init(name: #keyPath(UIColor.systemIndigo), color: .systemIndigo),
          .init(name: #keyPath(UIColor.systemOrange), color: .systemOrange),
          .init(name: #keyPath(UIColor.systemPink), color: .systemPink),
          .init(name: #keyPath(UIColor.systemPurple), color: .systemPurple),
          .init(name: #keyPath(UIColor.systemRed), color: .systemRed),
          .init(name: #keyPath(UIColor.systemTeal), color: .systemTeal),
          .init(name: #keyPath(UIColor.systemYellow), color: .systemYellow)
        ]),
        .init(title: "ADAPTABLE GRAY", rows: [
          .init(name: #keyPath(UIColor.systemGray), color: .systemGray),
          .init(name: #keyPath(UIColor.systemGray2), color: .systemGray2),
          .init(name: #keyPath(UIColor.systemGray3), color: .systemGray3),
          .init(name: #keyPath(UIColor.systemGray4), color: .systemGray4),
          .init(name: #keyPath(UIColor.systemGray5), color: .systemGray5),
          .init(name: #keyPath(UIColor.systemGray6), color: .systemGray6)
        ]),
        .init(title: "NONADAPTABLE", rows: [
          .init(name: #keyPath(UIColor.darkText), color: .darkText),
          .init(name: #keyPath(UIColor.lightText), color: .lightText)
        ]),
        .init(title: "TRANSPARENT", rows: [
          .init(name: #keyPath(UIColor.clear), color: .clear)
        ]),
        .init(title: "FIXED", rows: [
          .init(name: #keyPath(UIColor.black), color: .black),
          .init(name: #keyPath(UIColor.blue), color: .blue),
          .init(name: #keyPath(UIColor.brown), color: .brown),
          .init(name: #keyPath(UIColor.cyan), color: .cyan),
          .init(name: #keyPath(UIColor.darkGray), color: .darkGray),
          .init(name: #keyPath(UIColor.gray), color: .gray),
          .init(name: #keyPath(UIColor.green), color: .green),
          .init(name: #keyPath(UIColor.lightGray), color: .lightGray),
          .init(name: #keyPath(UIColor.magenta), color: .magenta),
          .init(name: #keyPath(UIColor.orange), color: .orange),
          .init(name: #keyPath(UIColor.purple), color: .purple),
          .init(name: #keyPath(UIColor.red), color: .red),
          .init(name: #keyPath(UIColor.white), color: .white),
          .init(name: #keyPath(UIColor.yellow), color: .yellow)
        ])
      ]
    } else {
      return [.init(title: "Dynamic Colours Only Available in iOS 13 and above", rows: [])]
    }
  }

}
