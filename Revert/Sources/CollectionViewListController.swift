// Copyright © 2020 Itty Bitty Apps. All rights reserved.

import UIKit

final class CollectionViewListController: RevertCollectionViewController {
  fileprivate enum Section: CaseIterable {
    case countries
  }

  fileprivate let countries = Country.countries

  @available(iOS 14.0, *)
  fileprivate lazy var dataSource: UICollectionViewDiffableDataSource<Section, Country> = {
    let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Country> { cell, _, country in
      var content = cell.defaultContentConfiguration()
      content.text = country.name
      content.secondaryText = country.capital

      cell.contentConfiguration = content
    }

    return UICollectionViewDiffableDataSource<Section, Country>(collectionView: collectionView) { (collectionView, indexPath, country) -> UICollectionViewCell? in
      collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: country)
    }
  }()

  override func viewDidLoad() {
    if #available(iOS 14.0, *) {
      configureLayout()
      applySnapshot()
      configureRefreshControl()
    }
  }

  @available(iOS 13.0, *)
  func configureRefreshControl () {
    // Add the refresh control to your UIScrollView object.
    collectionView.refreshControl = UIRefreshControl()
    collectionView.refreshControl?.addTarget(
      self, action:
      #selector(handleRefreshControl),
      for: .valueChanged
    )
  }

  @available(iOS 13.0, *)
  @objc func handleRefreshControl() {
    Task {
      try? await Task.sleep(nanoseconds: 3_000_000_000)
      await MainActor.run {
        self.collectionView.refreshControl?.endRefreshing()
      }
    }
  }
}

// MARK: - iOS 13 and below configuration
extension CollectionViewListController: UICollectionViewDelegateFlowLayout {
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return Section.allCases.count
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.countries.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewListCell", for: indexPath) as? CollectionViewListCell else {
      fatalError("Expecting to dequeue a \(CollectionViewListCell.self) from the collection view")
    }
    cell.label.text = countries[indexPath.row].name

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 2)
  }
}

// MARK: - iOS 14 configuration
@available(iOS 14.0, *)
private extension CollectionViewListController {
  func applySnapshot() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Country>()
    snapshot.appendSections(Section.allCases)
    snapshot.appendItems(countries, toSection: .countries)
    dataSource.apply(snapshot, animatingDifferences: false)
  }

  func configureLayout() {
    var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
    config.backgroundColor = .systemGroupedBackground
    collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
  }
}

fileprivate extension Country {

  static var countries: [Country] {
    if #available(iOS 14.0, *) {
      let countrySection: [CountrySection] = RevertItems.capitalCities.data()
      let countries = countrySection.first?.rows.compactMap { $0 }

      return countries ?? [Country]()
    }

    return [Country(name: "Collection View List only available in iOS 14 and above", capital: nil)]
  }
}
