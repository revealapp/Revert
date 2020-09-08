// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import UIKit

final class CollectionViewListController: RevertCollectionViewController {
  fileprivate enum Section: CaseIterable {
    case capitals
  }

  fileprivate let capitals = Country.countryCapitals

  @available(iOS 14.0, *)
  fileprivate lazy var dataSource: UICollectionViewDiffableDataSource<Section, String> = {
    let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, capital in
      var content = cell.defaultContentConfiguration()
      content.text = capital

      cell.contentConfiguration = content
    }

    return UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) { (collectionView, indexPath, country) -> UICollectionViewCell? in
      collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: country)
    }
  }()

  override func viewDidLoad() {
    if #available(iOS 14.0, *) {
      setup()
      createLayout()
      applySnapshot(animatingDifferences: true)
    }
  }
}

// MARK: - iOS 13 and below configuration
extension CollectionViewListController: UICollectionViewDelegateFlowLayout {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Section.allCases.count
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return capitals.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewListCell", for: indexPath) as? CollectionViewListCell else {
      fatalError("Expecting to dequeue a \(CollectionViewListCell.self) from the collection view")
    }
    cell.label.text = capitals[indexPath.row]

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 2)
  }
}


// MARK: - iOS 14 configuration
@available(iOS 14.0, *)
private extension CollectionViewListController {
  var config: UICollectionLayoutListConfiguration {
    return UICollectionLayoutListConfiguration(appearance: .insetGrouped)
  }

  func setup() {
    collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)

  }

  func applySnapshot(animatingDifferences: Bool = true) {
      var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
      snapshot.appendSections(Section.allCases)
      snapshot.appendItems(capitals)
      dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
  }

  func createLayout() {
      var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
      config.backgroundColor = .systemGroupedBackground
      collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
  }
}

fileprivate extension Country {

  static var countryCapitals: [String] {
    if #available(iOS 14.0, *) {
      let countrySection: [CountrySection] = RevertItems.capitalCities.data()
      let capitals = countrySection.first?.rows.compactMap { $0.name }

      return capitals ?? [String]()
    }

    return ["Collection View List only available in iOS 14 and above"]
  }
}
