# ReviewRelic

[![Version](https://img.shields.io/cocoapods/v/ReviewRelic.svg?style=flat)](https://cocoapods.org/pods/ReviewRelic)
[![License](https://img.shields.io/cocoapods/l/ReviewRelic.svg?style=flat)](https://cocoapods.org/pods/ReviewRelic)
[![Platform](https://img.shields.io/cocoapods/p/ReviewRelic.svg?style=flat)](https://cocoapods.org/pods/ReviewRelic)


❮img src="Screenshots/L1.png" width="100" ❯❮img src="Screenshots/L2.png" width="100" ❯❮img src="Screenshots/L3.gig" width="100" ❯

❮img src="Screenshots/D1.png" width="100" ❯❮img src="Screenshots/D2.png" width="100" ❯

Create a Seamless Review Experience For your Mobile Apps. Collect powerful feedback from your iOS native app with Reviewrelic’s flexible and easy-to-install SDK for IOS

## Requirements

- iOS 12+
- Swift 5+
- Full customizalble themes
- Support for dark mode

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

ReviewRelic is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ReviewRelic'
```

## Initialization
In didFinishLaunchingWithOptions initialize with APIKey and AppSecret from admin panel.
```ruby
ReviewRelic.shared.initialize(
apiKey: APIKEY, 
appSecret: APPSECRET,
merchantId: MERCHANT_ID)
```

### Presenting ReviewRelic

First confirm to ReviewRelicItem and create an item to be reviewed
```ruby
public protocol ReviewRelicItem {
    var transactionId: String? { get set } // Additional parameter to identify transaction
    var reviewsId: String? { get set} // Additional parameter to identify application user
}
```

Initializing ReviewController, and Presentaiton 
```ruby
///item is optional
let controller = presentReviewRelic(item: <ReviewRelicItem>(), completion: {
})
OR
let controller = presentReviewRelic()
```
Setting messages and additional styling
```ruby
public func setHeadingLabel(text: String, font: UIFont? = .boldSystemFont(ofSize: 14), textColor: UIColor? = .darkText) {
public func setDescriptionLabel(text: String, font: UIFont? = .systemFont(ofSize: 14), textColor: UIColor? = .darkText) {
public var thankYouText: String // Set message after successful submission
```
### Delgation

```ruby
func reviewRelicViewController(_: ReviewRelicViewController, submittedReviewRating data: ReviewRelic.Transaction)
func reviewRelicViewControllerRatingSubmissionFailed(_: ReviewRelicViewController)
func reviewRelicViewControllerLoadSettingsFailed(_: ReviewRelicViewController)
```

## License

ReviewRelic is available under the Apache license. See the LICENSE file for more info.
