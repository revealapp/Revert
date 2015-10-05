## Table View

An indexed `UITableView` listing a selection of countries and their capitals.

## Collection View

A `UICollectionView` with a two column layout. Tapping a cell will update its background colour to grey.

## Scroll View

A `UIScrollView` containing a large scrollable image.

## Stacked View

An example of embedding `UIStackView` in `UIStackView`.

## Default Views

A selection of stock UIKit views:

- `UITextView`
- `UIImageView`
- `MPVolumeView` (not available in the simulator)
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
- `UITextField` with a custom input view (x2)

## Bars

A selection of stock UIKit bar views:

- `UISearchBar`
- `UIToolBar` with an embedded UIBarButtonItem.
- `UITabBar`

## Alert View

Shows the new iOS 8 and old iOS 7 methods of presenting alert views and action sheets. `UIAlertController` is only available on iOS8, so it will not be shown on devices running iOS 7.

Under iOS 7, alert views and action sheets are not inspectable through _Reveal_ as they are removed from the application’s list of windows. 

On iOS8, `UIAlertController` is available and presented as a regular `UIViewController` and can be inspected via _Reveal_. See [this knowledge base article](http://support.revealapp.com/kb/faq/why-cant-i-inspect-uialertviews-in-reveal-in-ios-7) for more information.

## Picker View

`UIDatePicker` and `UIPicker`.

## Map View

`MKMapView` displays the origin of Itty Bitty Apps employees. All the annotations are linked together by an `MKPolygon`.

## Web View

[Reveal's](http://www.revealapp.com) website displayed in both a `UIWebView` and a `WKWebView`. `WKWebView` is only available on iOS8.

## SpriteKit View

Sample SpriteKit project that drops in a _Reveal_ logo on each tap.

## OpenGL View

3D Cube rotating at the center of the screen that has been textured with _Reveal_'s logo.

## Modal View

An example of modally presenting a view controller.

## Arranged Views

A selection of coloured views surrounded by slim hairline views.

Select any view to inspect its attributes through _Reveal_. A good example: try updating a view’s background color, it’s alpha value or its hidden property to see the changes being reflected in _Reveal_ and on your device or simulator.

## Auto Layout 

A scenario demoing the following Auto Layout attributes:

- Leading / Trailing space: Both white views have their leading / trailing edge pinned to a common superview.
- Horizontal spacing: Both white views are separated by a fixed horizontal constraint.
- Align Centre X / Y: Both inner blue views are centered within their respective superviews.
- Ratio: Blue views width and height are constrained a ratio of 1:1.
- Proportional constraints: The blue views' heights are constrained to be half of the their white container's height.
- Equals: Both white views are constrained to have equal widths and heights.

Try updating the constant value of the horizontal constraint separating both white `UIViews` and see the changes being reflected in _Reveal_ and on your device or simulator.

## Auto Layout Alignments

Demonstrates the following Auto Layout alignment scenarios:

- Leading / Trailing alignment: Both blue views have their leading / trailing edges aligned to the orange view’s leading / trailing edges.
- Top / Bottom alignment: Green views have their top and bottom edges aligned to the grey view’s top and bottom edges.
- Baseline / Vertical / Horizontal alignment: Labels are baseline / vertically / horizontally aligned with their counterparts.
- Alignment Rects: White, semi-transparent views are constrained to the alignment rect of the central red view.

Try updating the constant value of the orange view's width constraint and see the changes being reflected in _Reveal_ and on your device or simulator.

## Auto Layout Margins

Showcases Auto Layout alignments, pinning and layout margins interacting. The widths of all squares have have been constrained to be equal to the width of the centre square.

A `UISlider` is displayed on devices running iOS8+. The slider's value is bound to the centre square's `layoutMargins` attribute.

Try updating the constant value of the centre view's width constraint and see the changes being reflected in _Reveal_ and on your device or simulator.

## Autoresizing Masks

Shows the following scenarios involving autoresizing masks:

- Flexible Width: Blue view stretches horizontally while staying the same distance from the left / top / right margins.
- Flexible Height & Left / Right margins: Orange view stretches vertically while staying horizontally centred.
- Flexible Top / Bottom / Right margins: Green view stays vertically centred while staying the same distance from the left margin.
- Flexible Top / Bottom / Left margins: Purple view stays vertically centred while staying the same distance from the right margin.

Try updating the centre view’s resizing mask and deselect `.RightMargin`, then rotate your device or simulator and refresh _Reveal_ to see the changes.

## Transformed Views

A selection of transformed views with embedded subviews showing both the transformed and identity (non-transformed) positions:

- Translate: A view that has been translated (-20, 20).
- Rotate: A view that has been rotated 15°.
- Scale: A view that has been scaled by 50%.

The behaviour when mixing constraints and transforms has changed between iOS7 and iOS8. For more information please see [our blog post](http://revealapp.com/blog/constraints-and-transforms.html).

## Transformed Layers

A selection of transformed layers with subviews showing both the transformed and identity (non-transformed) positions:

- Y Rotate: A layer that has been rotated 15° on the Y axis.
- X Rotate: A layer that has been rotated 15° on the X axis.
- Z Rotate: A layer that has been rotated 15° on the Z axis.
- XY Rotate: A layer that has been rotated 15° on both the X and Y axes.

The behaviour when mixing constraints and transforms has changed between iOS7 and iOS8. For more information please see [our blog post](http://revealapp.com/blog/constraints-and-transforms.html).


## Layer Properties

A collection of different `CALayer` subclasses:

- `CATextLayer`
- `CAEmitterLayer`
- `CAShapeLayer`
- `CAScrollLayer`
- `CAGradientLayer`
- `CAReplicatorLayer`
- `CATiledLayer`
- `CAAEGLayer`

## Bounds & Anchor Point Changes

Examples of bounds and anchor point changes.

Try updating the anchor point or the bounds of the purple view and see the changes appear in both _Reveal_ and on your device or simulator.

The behaviour when mixing constraints and transforms has changed between iOS7 and iOS8. For more information please see [our blog post](http://revealapp.com/blog/constraints-and-transforms.html).

## Super Deep View Hierarchy

Embedded subviews forming a pyramid. Each subview is inset 5 pixels from the bounds of it's superview.

## Stress Test

A `UICollectionView` containing a pyramid of subviews in each cell.

## Not Serializable

An example of a view controller containing subviews with unserializable properties. Modifying the `UISlider` will cause the app to crash.
