//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class StressTestViewController: RevertCollectionViewController {}

// MARK: - UICollectionViewDataSource
extension StressTestViewController {

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: Storyboards.Cell.Stress, for: indexPath)
  }
}
