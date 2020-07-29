# FPHNavigationController-swift

[![CI Status](https://img.shields.io/travis/fupenghua/FPHNavigationController-swift.svg?style=flat)](https://travis-ci.org/fupenghua/FPHNavigationController-swift)
[![Version](https://img.shields.io/cocoapods/v/FPHNavigationController-swift.svg?style=flat)](https://cocoapods.org/pods/FPHNavigationController-swift)
[![License](https://img.shields.io/cocoapods/l/FPHNavigationController-swift.svg?style=flat)](https://cocoapods.org/pods/FPHNavigationController-swift)
[![Platform](https://img.shields.io/cocoapods/p/FPHNavigationController-swift.svg?style=flat)](https://cocoapods.org/pods/FPHNavigationController-swift)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

FPHNavigationController-swift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FPHNavigationController-swift'
```

## Author

fupenghua, 390908980@qq.com

## License

FPHNavigationController-swift is available under the MIT license. See the LICENSE file for more info.
=======
swift版本自定义导航+fix left item space，隐藏系统navigationBar，然后在每个controller添加一个navigationBar，内部适配了左按钮的左边距

### 使用
创建导航控制器时候使用FPHNavigationViewController创建，也可以继承该类

在AppDelegate中添加
```
private static let runOnce: Void = {
      ClassLoad.harmlessFunction()
  }()
  
  override open var next: UIResponder? {
      AppDelegate.runOnce
      return super.next
  }
  ```
