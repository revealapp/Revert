# REVEal Rendering Test

Revert is a sample iOS application destined to be inspected with @revealapp. It showcases UIKit's stock views and controls as well as specific view scenarios. It is an Universal app running on iOS7+ devices which supports portrait and lanscape orientation. It also support implement iOS7+ dynamic type system setting.

## Getting Started

Run the following steps to start inspecting _Revert_ with _Reveal_:

- Download and clone the repository: _git clone https://github.com/revealapp/revert.git_
- Open Revert: _open revert/Revert.xcodeproj_
- Run the project: _⌘+ R_
- Launch _Reveal_ and connect to device / simulator

## Changes between iOS Versions

The behaviour when mixing constraint and transform has evolved between iOS7 and iOS8. Hence, any view controllers dealing with transforms (`TransformViewsViewController`, `TransformLayersViewController`, `AnchorPointBoundsChangeViewController`) behave differently if running on iOS7 or on iOS8. For more information please see [this blog post](http://revealapp.com/blog/constraints-and-transforms.html).

## More about Reveal

- Web: [revealapp.com](https://www.revealapp.com)
- Twitter: [@reveal_app](https://twitter.com/reveal_app)
- GitHub: [@revealapp](https://github.com/revealapp)