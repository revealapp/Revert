// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import Foundation

final class NewCollectionDataSource<Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource {
  typealias CellConfigurator = (Cell, _ item: HomeItem) -> Void
  typealias GroupFilterClosure = ((HomeSectionItem) -> Bool)
  typealias ItemFilterClosure = (HomeItem) -> Bool

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
    return sections[indexPath.section].rows[indexPath.row]
  }

  func clearFilter() {
    sections = unfilteredSections
  }

  func filter(_ filterClosure: ItemFilterClosure) {
    sections = unfilteredSections.map { section in
      let filteredRows = section.rows.filter(filterClosure)
      return HomeSectionItem(title: section.title, rows: filteredRows)
    }
    .filter { $0.rows.count > 0 }
  }

  func filterGroups(_ filterClosure: GroupFilterClosure) {
    sections = unfilteredSections.filter(filterClosure)
  }
}
