# REVEal Rendering Test
[![Build status](https://badge.buildkite.com/808be6190e39e59f227d054db81a083b8a485e9de3fbeb02a6.svg)](https://buildkite.com/itty-bitty-apps/revert)

Revert is a sample iOS application destined to be inspected with @revealapp. It showcases UIKit's stock views and controls as well as specific view scenarios. It is an Universal app running on iOS7+ devices which supports portrait and lanscape orientation. It also implement iOS7 dynamic type system setting.

## Getting Started

Run the following steps to start inspecting _Revert_ with _Reveal_:

- Download and clone the repository: _git clone https://github.com/revealapp/revert.git_
- Open Revert: _open revert/Revert.xcodeproj_
- Run the project: _⌘ + R_
- Launch _Reveal_ and connect to device / simulator

## Changes between iOS Versions

The behaviour when mixing constraint and transform has evolved between iOS7 and iOS8. Hence, any view controllers dealing with transforms (`TransformViewsViewController`, `TransformLayersViewController`, `AnchorPointBoundsChangeViewController`) behave differently if running on iOS7 or on iOS8. For more information please see [this blog post](http://revealapp.com/blog/constraints-and-transforms.html).

## More about Reveal

- Web: [revealapp.com](https://www.revealapp.com)
- Twitter: [@reveal_app](https://twitter.com/reveal_app)
- GitHub: [@revealapp](https://github.com/revealapp)

## Licensing

<a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-nd/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-nd/4.0/">Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License</a>.