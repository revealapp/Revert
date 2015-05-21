## Table View

An indexed `UITableView` listing a selection of countries and their respective capitals.

## Collection View

A `UICollectionView` with a 2 column layout. Tapping a cell will update its background colour to grey.

## Scroll View

A `UIScrollView` containing a large scrollable image.

## Default Views

A selection of stock UIKit views:

- `UITextView`
- `UIImageView`
- `MPVolumeView` - not available in the simulator.
- `UIProgressView`
- `UILabel`

## Controls

A selection of stock UIKit controls:

- `UISegmentedControl` (x2)
- `UIStepper`
- `UISwitch`
- `UISlider`
- `UIPageControl`
- `UIButton` (x4)
- `UITextField` (x2)
- `UITextField` with custom input view (x2)

## Bars

A selection of stock UIKit bars:

- `UISearchBar`
- `UIToolBar` - with embedded UIBarButtonItem.
- `UITabBar`

## Alert View

Legacy and new way of presenting both alert views and action sheets. As `UIAlertController` is only available from iOS8, its usage has been hidden from any device running iOS7.

Legacy alert views and action sheets were not inspectable through _Reveal_ as they had been removed from the application’s `windows` property in iOS7. However on iOS8 `UIAlertController`,  is defined and presented as a regular `ViewController`, thus it is now inspectable via _Reveal_. See [this article](http://support.revealapp.com/kb/faq/why-cant-i-inspect-uialertviews-in-reveal-in-ios-7) for more information.

## Picker View

`UIDatePicker` and `UIPicker`.

## Map View

`MKMapView` displays the origin of Itty Bitty Apps employees. All the annotations are linked together by an `MKPolygon`.

## Web View

[Reveal's](http://www.revealapp.com) website displayed from both `UIWebView` and `WKWebView`. `WKWebView` is only available from iOS8.

## SpriteKit View

Sample SpriteKit project dropping a _Reveal_ logo on each tap.

## OpenGL View

3D Cube rotating on the center of the screen textured with _Reveal_'s logo.

## Modal View

A modal presentation of a view controller.

## Arranged Views

A selection of coloured views surrounded by slim hairline views.

Select any view to inspect its attributes through _Reveal_. For example, start by updating a view’s background color, it’s alpha value or its hidden property and see the changes being reflected in _Reveal_ and your device or simulator.

## Auto Layout 

An auto layout scenario demoing the following attributes:

- Leading / Trailing space: Both white views have their leading / trailing edge pinned to their common superview.
- Horizontal spacing: Both white views are separated by a fixed horizontal constraint.
- Align Centre X / Y: Both inner blue views are centred within their respective superview.
- Ratio: Blue views are 1:1 ratio constrained.
- Proportional constraints: The blue views’ heights are constrained to be half of the their white containers height.
- Equals: Both white views are constrained to have equal width / heights.

For example, update the constant value of the horizontal constraint separating both white `UIViews` and see the changes being reflected in _Reveal_ and your device or simulator.

## Auto Layout Alignments

An auto layout scenario demoing the following alignments attributes:

- Leading / Trailing alignment: Both blue views have their leading / trailing edges respectively aligned to the orange view’s leading / trailing edges.
- Top / Bottom alignment: Green views have their top and bottom edges respectively aligned to the grey view’s top and bottom edges.
- Baseline / Vertical / Horizontal alignment: Labels are baseline / vertically / horizontally aligned with their counterparts.
- Alignment Rects: White semi-transparent views are constrained to the central red view’s custom alignment rect.

For example, update the orange view’s width constraint's constant and see the changes being reflected in _Reveal_ and your device or simulator.

## Auto Layout Margins

An auto layout scenario showcasing alignments, pinning and layout margins interacting altogether. All squares have their widths equals the width of the centre square.

A `UISlider` is displayed on devices running iOS8+ which is bound to the centre square’s `layoutMargins` attribute.

For example, update the centre's view width constraint constant through _Reveal_ and see the changes being reflected in _Reveal_ and your device or simulator.

## Autoresizing Masks

An autoresizing masks scenario showcasing:

- Flexible Width: Blue view stretches horizontally while staying at the same distance of the left / top / right margins.
- Flexible Height & Left / Right margins: Orange view stretches vertically while staying horizontally centred.
- Flexible Top / Bottom / Right margins: Green view stays vertically centred and always at the same distance of the left margin.
- Flexible Top / Bottom / Left margins: Purple view stays vertically centred and always at the same distance of the right margin.

For example, update the centre view’s resizing mask through _Reveal_ and deselect `.RightMargin`, then rotate the device or simulator to see the changes being reflected in _Reveal_ and your device or simulator.

## Transform Views

A selection of transformed views with embeded subviews:

- Translate: (-20, 20) translated purple view displayed next to its original view.
- Rotate: 15° rotated purple view displayed next to its original view.
- Scale: 50% scaled purple view displayed next to its original view.

The behaviour when mixing constraint and transform has evolved between iOS7 and iOS8. For more information please see [this blog post](http://revealapp.com/blog/constraints-and-transforms.html).

## Transform Layers

A selection of transformed layers with subviews:

- Y Rotate: 15° rotated purple view on the Y axis.
- X Rotate: 15° rotated purple view on the X axis.
- Z Rotate: 15° rotated purple view on the Z axis.
- XY Rotate: A combination of a 15° rotation on the X and Y axis.

The behaviour when mixing constraint and transform has evolved between iOS7 and iOS8. For more information please see [this blog post](http://revealapp.com/blog/constraints-and-transforms.html).


## Layer Properties

A collection of different `CALayer`:

- `CATextLayer`
- `CAEmitterLayer`
- `CAShapeLayer`
- `CAScrollLayer`
- `CAGradientLayer`
- `CAReplicatorLayer`
- `CATiledLayer`
- `CAAEGLayer`

## Bounds & Anchor Point changes

Scenarios of bounds and anchor point changes.

For example, update the anchor point or the bounds of the purple view and see their changes appear in both _Reveal_ and the device or simulator.

The behaviour when mixing constraint and transform has evolved between iOS7 and iOS8. For more information please see [this blog post](http://revealapp.com/blog/constraints-and-transforms.html).

## Super Deep

Embedded coloured subviews forming a pyramid. Each subview is 5pts from its superview’ bounds.

## Stress Test

A `UICollectionView` containing a pyramid of subviews on each cell.

## Not Serializable

A view controller containing unserializable properties on its subviews. Is is expected that modifying the `UISlider` makes the app crash.
