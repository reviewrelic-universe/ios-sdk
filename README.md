# ReviewRelic

[![CI Status](https://img.shields.io/travis/raheelsadiq/ReviewRelic.svg?style=flat)](https://travis-ci.org/raheelsadiq/ReviewRelic)
[![Version](https://img.shields.io/cocoapods/v/ReviewRelic.svg?style=flat)](https://cocoapods.org/pods/ReviewRelic)
[![License](https://img.shields.io/cocoapods/l/ReviewRelic.svg?style=flat)](https://cocoapods.org/pods/ReviewRelic)
[![Platform](https://img.shields.io/cocoapods/p/ReviewRelic.svg?style=flat)](https://cocoapods.org/pods/ReviewRelic)


Create a Seamless Review Experience For your Mobile Apps. Collect powerful feedback from your iOS native app with Reviewrelic’s flexible and easy-to-install SDK for IOS
- iOS 12+
- Swift 5+
- Full customizalble themes
- Support for dark mode

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ReviewRelic is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ReviewRelic'
```

## Initialization
In didFinishLaunchingWithOptions initialize with APIKey and AppSecret from admin panel.
```ruby
ReviewRelic.shared.initialize(apiKey: APIKEY, appSecret: APPSECRET)
```

### Presenting ReviewRelic

First confirm to ReviewRelicItem and create an item to be reviewed
```ruby
public protocol ReviewRelicItem {
    var transactionId: String { get set }
    var reviewsId: String? { get set} // Additional parameter to identify application user
}
```

Initializing ReviewController with Item, and Presentaiton 
```ruby
let controller = presentReviewRelic(item: <ReviewRelicItem>()) {
}
```
Setting messages and additional styling
```ruby
public func setHeadingLabel(text: String, font: UIFont? = .boldSystemFont(ofSize: 14), textColor: UIColor? = .darkText) {
public func setDescriptionLabel(text: String, font: UIFont? = .systemFont(ofSize: 14), textColor: UIColor? = .darkText) {
```
### Delgation

```ruby
func reviewRelicViewController(_: ReviewRelicViewController, submittedReviewRating data: ReviewRelic.Transaction)
func reviewRelicViewControllerRatingSubmissionFailed(_: ReviewRelicViewController)
func reviewRelicViewControllerLoadSettingsFailed(_: ReviewRelicViewController)
```

## License

ReviewRelic is available under the Apache license. See the LICENSE file for more info.
