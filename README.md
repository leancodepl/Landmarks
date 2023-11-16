# Landmarks

A simple app from [Apple's SwiftUI tutorial](https://developer.apple.com/tutorials/swiftui/creating-and-combining-views).

## Running tests

This app uses XCTestPlans.

### Locally

```
xcodebuild test \
  -scheme Landmarks \
  -destination 'platform=iOS Simulator,name=iPhone 15'
```

### BrowserStack

First, get your credentials from BrowserStack:

```
export BROWSERSTACK_CREDS=bartekpacia_ODK8TJ:cyc1fLfWkqBxHuzkK4ag
```

Then, simply run `bs_ios`:

```
./bs_ios
```
