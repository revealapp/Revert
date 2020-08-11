// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import Foundation

final class NewCollectionDataSource<Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource {
  typealias CellConfigurator = (Cell, _ item: HomeItem) -> Void
  typealias GroupFilterClosure = ((HomeSectionItem) -> Bool)

  // MARK: - Private properties
  private let unfilteredSections: [HomeSectionItem]
  private var sections: [HomeSectionItem]
  private let cellIdentifier: String
  private let configureCell: CellConfigurator

  // MARK: - Init
  required init(sections: [HomeSectionItem], configureCell: @escaping CellConfigurator, cellIdentifier: String) {
    self.unfilteredSections = sections
    self.sections = sections
    self.configureCell = configureCell
    self.cellIdentifier = cellIdentifier

    super.init()
  }

  // MARK: - UICollectionViewDataSource
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    sections.count
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    sections[section].rows.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? Cell else {
      fatalError("Expecting to dequeue a `CollectionViewCell` from the collectionView")
    }

    let item = sections[indexPath.section].rows[indexPath.row]
    self.configureCell(cell, item)
    return cell
  }

  // MARK: - Public methods
  subscript(indexPath: IndexPath) -> HomeItem {
    return self.sections[indexPath.section].rows[indexPath.row]
  }

  func clearFilter() {
    self.sections = self.unfilteredSections
  }

  func filterGroups(_ filterClosure: GroupFilterClosure) {
    self.sections = self.unfilteredSections.filter(filterClosure)
  }
}
