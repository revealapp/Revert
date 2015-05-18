Table View
----------------

A simple indexed `UITableView` listing a selection of countries and their respective capitals.  Countries are sorted and grouped alphabetically. Each section display both a `UITableViewHeaderView` and `UITableViewFooterView`. Each custom cell contains a `.Checkmark` as their `accessoryType`.

Collection View
----------------

A `UICollectionView` with a simple 2 column layout. Tapping a cell will update its background colour to grey.

Scroll View
----------------

A `UIScrollView` containing a large scrollable image.

Default Views
----------------

A selection of stock UIKit views:

- `UITextView`
- `UIImageView`
- `MPVolumeView` - not available in the simulator.
- `UIProgressView`
- `UILabel`

Controls
----------------

A selection of stock UIKit controls:

- `UISegmentedControl` (x2)
- `UIStepper`
- `UISwitch`
- `UISlider`
- `UIPageControl`
- `UIButton` (x4)
- `UITextField` (x2)
- `UITextField` with custom input view (x2)

Bars
----------------

A selection of stock UIKit bars:

- `UISearchBar`
- `UIToolBar` - with embedded UIBarButtonItem.
- `UITabBar`

Alert View
----------------

Legacy and new way of presenting both alert views and action sheets. As `UIAlertController` is only present on iOS 8+, its usage is hidden from device running iOS 7.

Legacy alert views and action sheets are not rendered in Reveal as they have been removed from the application’s view hierarchy on iOS 7. `UIAlertController` however add presents alert views and action sheets as any view controller would be presented - hence they are back in the view hierarchy. See http://support.revealapp.com/kb/faq/why-cant-i-inspect-uialertviews-in-reveal-in-ios-7 for more info.

Picker View
----------------

`UIDatePicker` and `UIPicker`.

Map View
----------------

`MKMapView` displays the origin of Itty Bitty Apps employees. All the annotations are linked together by an `MKPolygon`.

Web View
----------------

Revealapp.com website displayed from both `UIWebView` and `WKWebView`. `WKWebView` is only available from iOS 8.

SpriteKit View
----------------

Sample SpriteKit project dropping a Reveal logo on each tap.

OpenGL View
----------------

TODO

Modal View
----------------

A simple modal presentation of a view controller.

Arranged Views
----------------

A selection of coloured views surrounded by slim hairline views.

Select any view to inspect the basic `UIView` attributes through Reveal. For example, start by updating a view’s background color, it’s alpha value or its hidden property and see the changes appear both in Reveal and your device / simulator.

Auto Layout 
----------------

An auto layout scenario demoing the following basic attributes:

- Leading / Trailing space: Both white views have their leading / trailing edge pinned to their common superview.
- Horizontal spacing: Both white views are separated by a fixed horizontal constraint.
- Align Centre X / Y: Both inner blue views are centred on their respective superview.
- Ratio: Blue squares are 1:1 constrained to always be squares.
Proportional constraints: The blue views’ heights are constrained to be half of the their containers height.
- Equals: Both white views are constrained to have equal width / heights.

For example, update the constant value of the horizontal spacing constraint between both white `UIViews` and see the changes appear both in Reveal and your device / simulator.

Auto Layout Alignments
----------------

An auto layout scenario demoing the following alignments attributes:

- Leading / Trailing alignment: Both blue views have their leading / trailing edges respectively aligned to the orange view’s leading / trailing edges.
- Top / Bottom alignment: Green views have their top and bottom edges respectively aligned to the grey view’s top and bottom edges.
- Baseline / Vertical / Horizontal alignment: Labels are baseline / vertically / horizontally aligned with their counterparts.
- Alignment Rects: White semi-transparent views are constrained to the central red view’s custom alignment rect.

For example, update the orange view’s width constraint constant and see the changes appear both in Reveal and your device / simulator.

Auto Layout Margins
----------------

An auto layout scenario showcasing alignments, pinning and layout margins interacting altogether. All squares have their width equals the width of the centre square.

A `UISlider` is displayed on devices running iOS 8+ which is bound to the centre square’s layoutMargins.

For example, update the centre's view width constraint constant through Reveal and see the changes appear both in Reveal and your device / simulator.

Autoresizing Masks
----------------

An autoresizing masks scenario showcasing:

- Flexible Width: Blue view stretches horizontally while staying at the same distance of the left / top / right margins.
- Flexible Height & Left / Right margins: Orange view stretches vertically while staying horizontally centred.
- Flexible Top / Bottom / Right margins: Green view stays vertically centred and always at the same distance of the left margin.
- Flexible Top / Bottom / Left margins: Purple view stays vertically centred and always at the same distance of the right margin.

For example, update the centre view’s resizing mask through Reveal and deselect `.RightMargin`, then rotate the device / simulator to see the changes.

Transform Views
----------------

A selection of transformed view containing subviews:

- Translate: Translated purple view displayed next to its original view.
- Rotate: Rotated purple view displayed next to its original view.
- Scale: Scaled purple view displayed next to its original view.

The behaviour when mixing constraint and transform on iOS 7 is broken and has been fixed on iOS 8. See http://revealapp.com/blog/constraints-and-transforms.html for more info.

Transform Layers
----------------

A selection of transformed layers with subviews:

- Y Rotate: 15° rotated purple view on the Y axis.
- X Rotate: 15° rotated purple view on the X axis.
- Z Rotate: 15° rotated purple view on the Z axis.
- XY Rotate: A combination of a 15° rotation on the X and Y axis.

The behaviour when mixing constraint and transform on iOS 7 is broken and has been fixed on iOS 8. See http://revealapp.com/blog/constraints-and-transforms.html for more info.

Layer Properties
----------------

A collection of different `CALayers`:

- `CATextLayer`
- `CAEmitterLayer`
- `CAShapeLayer`
- `CAScrollLayer`
- `CAGradientLayer`
- `CAReplicatorLayer`
- `CATiledLayer`
- `CAAEGLayer`

Bounds & Anchor Point changes
----------------

Scenarios of bounds and anchor point changes.

For example, update the anchor point or the bounds of the purple view and see their changes appear in both Reveal and the device / simulator.

The behaviour when mixing constraint and transform on iOS 7 is broken and has been fixed on iOS 8. See http://revealapp.com/blog/constraints-and-transforms.html for more info.

Super Deep
----------------

Embedded coloured subviews forming a pyramid. Each subview is 5pts from its superview’ bounds.

Stress Test
----------------

A `UICollectionView` containing a pyramid of subviews on each `UICollectionViewCell`.

Not Serializable
----------------

A view controller containing unserializable properties on its subviews. Is is expected that modifying the `UISlider` makes the app crash.