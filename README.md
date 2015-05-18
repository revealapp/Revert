# Revert

Revert is a Universal iOS 7+ application destined to be inspected through @reveal_app.

_The application also supports dynamic type._

## Architecture

Revert loads its data for dynamic view controllers from `plist` files. Following is a table mapping between the view controller, the used data source and its `plist` file.


View Controller | Data Source | Plist File
--- | --- | ---
`HomeViewController` | `HomeDataSource` | `HomeItems.plist`
`CountriesViewController` | `CountriesDataSource` | `CountriesCapitals.plist`
`ControlsViewController` | `ControlsDataSource` | `ControlItems.plist`, `ViewItems.plist`
`LayerPropertiesViewController` | `ControlsDataSource` | `LayerPropertiesItems.plist`
`AlertsViewController` | `AlertsDataSource` | `AlertItems.plist`
`MapViewController` | _None_ | `MapLocations.plist`

All the `plist` files are deserialised and mapped into objects via the `Collectable` protocol. These objects are then grouped and stored within `CollectableGroup<T>` embeded in a `CollectableCollection<T>`.

## View Controllers

All view controllers apart from `HomeViewController` and `InfoViewController` inherit from either one of the following custom view controllers:

- `RevertViewController`
- `RevertTableViewController`
- `RevertCollectionViewController`
- `RevertGLKViewController`

which all conform to the `SettableHomeItem` protocol. They are responsible for managing the `item` object by:

- Ensuring that an `item` object is set by the time `viewDidLoad` gets called.
- Configuring in a similar manner `InfoViewController` in `prepareForSegue:sender:` with `item` when the info button present on every screen is tapped.

