![Revert](http://images.revealapp.com.s3.amazonaws.com/revert_github/revert_top.jpg)
# REVEal Rendering Test - REVERT

Revert is a reference iOS project developed to help test the performance and accuracy of [Reveal](http://revealapp.com), a runtime view hierarchy inspection tool from [Itty Bitty Apps](http://ittybittyapps.com). It contains a number of examples which highlight both common and edge case scenarios. Revert is a universal iOS 7+ app that supports both portrait and landscape orientations.

We're releasing Revert so the community can compare the features and accuracy of the various view debuggers on the market and for our own regression and feature testing.

We've tried to include as many scenarios as possible, but if you'd like to add your own or suggest one that should be supported, please feel free to create a pull request or contact us directly via our [online support](http://support.revealapp.com).
<br><br>


![Revert](http://images.revealapp.com.s3.amazonaws.com/revert_github/revert.jpg) 
## Getting Started

Follow the steps below to start inspecting Revert with Reveal:

- [Download Reveal](http://revealapp.com/download/).
- Download and clone the repository: `git clone https://github.com/revealapp/revert.git`
- Open Revert: `open revert/Revert.xcodeproj`
- Follow the [integration guide](http://support.revealapp.com/kb/getting-started/integrating-reveal-with-your-ios-app) to enable Revert to be inspected by Reveal. We'd suggest [dynamically loading the library via a User breakpoint](http://support.revealapp.com/kb/getting-started/integrating-reveal-load-reveal-without-changing-your-xcode-project) as the easiest and most flexible option.
- Run the project: ⌘ + R
- Launch [Reveal](http://revealapp.com) and connect to Revert.

## Changes in behaviour between iOS Versions

Revert has helped us isolate changes in behaviour between iOS versions and verify that Reveal handles them correctly. As an example, the behaviour of constraints and transforms changed between iOS7 and iOS8. Any view controller in Revert dealing with transforms (`TransformViewsViewController`, `TransformLayersViewController`, `AnchorPointBoundsChangeViewController`) will behave differently when run on these two version of iOS. For more information please see [this blog post](http://revealapp.com/blog/constraints-and-transforms.html).

## More about Reveal

- [Web](https://www.revealapp.com)
- [Twitter](https://twitter.com/reveal_app)
- [GitHub](https://github.com/revealapp)
- [Support](http://support.revealapp.com)

[![Build status](https://badge.buildkite.com/808be6190e39e59f227d054db81a083b8a485e9de3fbeb02a6.svg)](https://buildkite.com/itty-bitty-apps/revert)

## Licensing

This work is licensed under a <a rel="license" href="https://opensource.org/licenses/BSD-3-Clause">BSD 3-Clause License</a>.
