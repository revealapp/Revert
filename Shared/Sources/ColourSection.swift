// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import Foundation

struct ColourSection {
  var title: String?
  var rows: [ColourItem]
}

extension RevertItems {

  static var coloursData: [ColourSection] {
    if #available(iOS 13.0, *) {
      let labelSection = ColourSection(title: "LABEL", rows: [
        ColourItem(name: #keyPath(UIColor.label), color: .label),
        ColourItem(name: #keyPath(UIColor.secondaryLabel), color: .secondaryLabel),
        ColourItem(name: #keyPath(UIColor.tertiaryLabel), color: .tertiaryLabel),
        ColourItem(name: #keyPath(UIColor.quaternaryLabel), color: .quaternaryLabel)
      ])

      let fillSection = ColourSection(title: "FILL", rows: [
        ColourItem(name: #keyPath(UIColor.systemFill), color: .systemFill),
        ColourItem(name: #keyPath(UIColor.secondarySystemFill), color: .secondarySystemFill),
        ColourItem(name: #keyPath(UIColor.tertiarySystemFill), color: .tertiarySystemFill),
        ColourItem(name: #keyPath(UIColor.quaternarySystemFill), color: .quaternarySystemFill)
      ])

      let textSection: ColourSection = ColourSection(title: "TEXT", rows: [
        ColourItem(name: #keyPath(UIColor.placeholderText), color: .placeholderText)
      ])

      let standardContentBackgroundSection = ColourSection(title: "STANDARD CONTENT BACKGROUND", rows: [
        ColourItem(name: #keyPath(UIColor.systemBackground), color: .systemBackground),
        ColourItem(name: #keyPath(UIColor.secondarySystemBackground), color: .secondarySystemBackground),
        ColourItem(name: #keyPath(UIColor.tertiarySystemBackground), color: .tertiarySystemBackground)
      ])

      let groupedContentBackgroundSection = ColourSection(title: "GROUPED CONTENT BACKGROUND", rows: [
        ColourItem(name: #keyPath(UIColor.systemGroupedBackground), color: .systemGroupedBackground),
        ColourItem(name: #keyPath(UIColor.secondarySystemGroupedBackground), color: .secondarySystemGroupedBackground),
        ColourItem(name: #keyPath(UIColor.tertiarySystemGroupedBackground), color: .tertiarySystemGroupedBackground)
      ])

      let separatorSection: ColourSection = ColourSection(title: "SEPARATOR", rows: [
        ColourItem(name: #keyPath(UIColor.separator), color: .separator),
        ColourItem(name: #keyPath(UIColor.opaqueSeparator), color: .opaqueSeparator)
      ])

      let linkSection: ColourSection = ColourSection(title: "LINK", rows: [
        ColourItem(name: #keyPath(UIColor.link), color: .link)
      ])

      let adaptableSection = ColourSection(title: "ADAPTABLE", rows: [
        ColourItem(name: #keyPath(UIColor.systemBlue), color: .systemBlue),
        ColourItem(name: #keyPath(UIColor.systemGreen), color: .systemGreen),
        ColourItem(name: #keyPath(UIColor.systemIndigo), color: .systemIndigo),
        ColourItem(name: #keyPath(UIColor.systemOrange), color: .systemOrange),
        ColourItem(name: #keyPath(UIColor.systemPink), color: .systemPink),
        ColourItem(name: #keyPath(UIColor.systemPurple), color: .systemPurple),
        ColourItem(name: #keyPath(UIColor.systemRed), color: .systemRed),
        ColourItem(name: #keyPath(UIColor.systemTeal), color: .systemTeal),
        ColourItem(name: #keyPath(UIColor.systemYellow), color: .systemYellow)
      ])

      let adaptableGraySection = ColourSection(title: "ADAPTABLE GRAY", rows: [
        ColourItem(name: #keyPath(UIColor.systemGray), color: .systemGray),
        ColourItem(name: #keyPath(UIColor.systemGray2), color: .systemGray2),
        ColourItem(name: #keyPath(UIColor.systemGray3), color: .systemGray3),
        ColourItem(name: #keyPath(UIColor.systemGray4), color: .systemGray4),
        ColourItem(name: #keyPath(UIColor.systemGray5), color: .systemGray5),
        ColourItem(name: #keyPath(UIColor.systemGray6), color: .systemGray6)
      ])

      let nonAdaptableSection = ColourSection(title: "NONADAPTABLE", rows: [
        ColourItem(name: #keyPath(UIColor.darkText), color: .darkText),
        ColourItem(name: #keyPath(UIColor.lightText), color: .lightText)
      ])

      let transparentSection = ColourSection(title: "TRANSPARENT", rows: [
        ColourItem(name: #keyPath(UIColor.clear), color: .clear)
      ])

      let fixedSection = ColourSection(title: "FIXED", rows: [
        ColourItem(name: #keyPath(UIColor.black), color: .black),
        ColourItem(name: #keyPath(UIColor.blue), color: .blue),
        ColourItem(name: #keyPath(UIColor.brown), color: .brown),
        ColourItem(name: #keyPath(UIColor.cyan), color: .cyan),
        ColourItem(name: #keyPath(UIColor.darkGray), color: .darkGray),
        ColourItem(name: #keyPath(UIColor.gray), color: .gray),
        ColourItem(name: #keyPath(UIColor.green), color: .green),
        ColourItem(name: #keyPath(UIColor.lightGray), color: .lightGray),
        ColourItem(name: #keyPath(UIColor.magenta), color: .magenta),
        ColourItem(name: #keyPath(UIColor.orange), color: .orange),
        ColourItem(name: #keyPath(UIColor.purple), color: .purple),
        ColourItem(name: #keyPath(UIColor.red), color: .red),
        ColourItem(name: #keyPath(UIColor.white), color: .white),
        ColourItem(name: #keyPath(UIColor.yellow), color: .yellow)
      ])

      return [
        labelSection,
        fillSection,
        textSection,
        standardContentBackgroundSection,
        groupedContentBackgroundSection,
        separatorSection,
        linkSection,
        adaptableSection,
        adaptableGraySection,
        nonAdaptableSection,
        transparentSection,
        fixedSection
      ]
    } else {
      return [ColourSection(title: "Dynamic Colours Only Available in iOS 13 and above", rows: [])]
    }
  }

}
