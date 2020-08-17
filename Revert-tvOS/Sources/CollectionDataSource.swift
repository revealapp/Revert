// Copyright © 2016 Itty Bitty Apps. All rights reserved.

import Foundation

final class CollectionDataSource<Section: SectionItem, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource {
  typealias CellConfigurator = (Cell, Section.item) -> Void
  typealias GroupFilterClosure = ((Section) -> Bool)
  typealias ItemFilterClosure = (Section.item) -> Bool

  // MARK: - Private properties

  private let unfilteredSections: [Section]
  private var sections: [Section]
  private let cellIdentifier: String
  private let configureCell: CellConfigurator

  // MARK: - Init

  required init(sections: [Section], configureCell: @escaping CellConfigurator, cellIdentifier: String) {
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
  
  subscript(indexPath: IndexPath) -> Section.item {
    return sections[indexPath.section].rows[indexPath.row]
  }

  func clearFilter() {
    sections = unfilteredSections
  }

  func filter(_ filterClosure: ItemFilterClosure) {
    sections = unfilteredSections.map { section in
      var newSection = section
      newSection.rows = newSection.rows.filter(filterClosure)
      return newSection
    }
    .filter { $0.rows.count > 0 }
  }

  func filterGroups(_ filterClosure: GroupFilterClosure) {
    sections = unfilteredSections.filter(filterClosure)
  }
}
