# Landmarks

A simple app from [Apple's SwiftUI tutorial](https://developer.apple.com/tutorials/swiftui/creating-and-combining-views).

## Running tests

This app uses XCTestPlans.

### Running locally

```
xcodebuild test \
  -scheme Landmarks \
  -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Running on BrowserStack

First, get your credentials from BrowserStack:

```
export BROWSERSTACK_CREDS=bartekpacia_XXXXXX:XXXXXYYYYYTTTTTEEEEE
```

Then, simply run `bs_ios`:

```
./bs_ios
```

If it fails because of code-signing, open Xcode and try ticking "Automatic Code
Signing" and modifying the bundle identifier if it's taken.
