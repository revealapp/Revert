 //
 //  Copyright © 2016 Itty Bitty Apps. All rights reserved.

import UIKit
 
final class HomeCollectionViewController: UICollectionViewController {
  required init?(coder aDecoder: NSCoder) {
    self.dataSource = CollectionDataSource(
      collection: self.collection,
      configureCell: self.dynamicType.configureCell,
      cellIdentifier: Storyboards.Cell.HomeCollection
    )

    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.collectionView?.dataSource = self.dataSource
  }

  //MARK: - Private
  private var collection = CollectableCollection<HomeItem>(items: .Home)
  private var dataSource: CollectionDataSource<HomeItem, HomeCollectionCell>
}
 
private extension HomeCollectionViewController {
  static func configureCell(cell: HomeCollectionCell, withItem item: HomeItem) {
    cell.titleLabel.text = item.title
    cell.imageView.image = UIImage(named: item.iconName)
    print(item.iconName)
  }
}
