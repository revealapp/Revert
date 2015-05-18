**Revert**
==========

Revert is a Universal iOS 7+ application destined to be inspected through @reveal_app.

It supports dynamic type.

Architecture
-----------

Revert uses `plist` files for data persistance. Main ressource file `HomeItems.plist` contains the data required for the `HomeViewController`. It represent the next level of view controllers (title, icon name, segue name and information text).

The following files contains the data required for cells and map based view controllers.

- `ControlItems.plist`
- `ViewItems.plist`
- `LayerPropertiesItems.plist`
- `MapLocations.plist`
- `CountriesCapitals.plist`
- `AlertItems.plist`

All the `plist` files are deserialised using a generic process and stored into `CollectableCollection<T>`. These contain a collection of `CollectableGroup<T>` representing a `UITableView` or `UICollectionView` section. Finally, these contain a collection of models of type `T`, with `T` being an object conforming to the `Collectable` protocol.

View Controllers
----------------

All view controllers besides `HomeViewController` and `InfoViewController` inherit from either one of these custom view controllers:

- `RevertViewController`
- `RevertTableViewController`
- `RevertCollectionViewController`
- `RevertGLKViewController`

which all conform to the `SettableHomeItem` protocol. They are responsible for managing the `item` object by:

- Ensures that an `item` object is set by the time `viewDidLoad` gets called.
- Configuring in a similar manner `InfoViewController` in `prepareForSegue:sender:` with `item` when the info button present on every screen is tapped.

