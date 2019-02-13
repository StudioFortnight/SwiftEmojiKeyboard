# SwiftEmojiKeyboard

<img src="https://i.imgur.com/wcNOp0f.png" width="30%"/>

## Description
A drop-in UI emoji keyboard written in Swift.

## Features.

- Bottom categories
- Supports the latest Emoji 11, Unicode 11, and CLDR 34 release versions
- Built directly from the emoji data source files

## Example

To run the example project, clone the repo, and run the project from the Example directory.

## Requirements

This project requires Xcode 10+ running a target of iOS 9.3+ along with Cocoapods.

## Installation

Drag the project directly into your xCode project.

## Usage

#### Setup

```swift
class HomeController: UIViewController, SwiftEmojiKeyboardDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    lazy var swiftEmojiKeyboard: SwiftEmojiKeyboard = {
        let swiftEmojiKeyboard = SwiftEmojiKeyboard()
        swiftEmojiKeyboard.delegate = self
        return swiftEmojiKeyboard
    }()
    
    fileprivate func setupController() {
        // ...
        
        yourTextField.inputView = swiftEmojiKeyboard
    }
    
}
```

#### Delegate methods

```swift
class HomeController: UIViewController, SwiftEmojiKeyboardDelegate {
    
    func swiftEmojiKeyboard(didSelect emoji: String, didSelectItemAt indexPath: IndexPath) {
        print(emoji)
        guard let text = yourTextField.text else {return}
        yourTextField.text = text + "\(emoji)"
    }
    
    func swiftEmojiKeyboard(didChangeCategoryAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func swiftEmojiKeyboard(didChangeKeyboard type: KeyboardType) {
        print(type)
    }
    
    func swiftEmojiKeyboard(didSelectReturn newLine: Bool) {
        print(newLine)
    }
    
    func swiftEmojiKeyboard(didSelectDelete delete: Bool) {
        print(delete)
    }
    
}
```

## Author

Fortnight Studio, development@fortnight.studio

## Credits

Emojibase: https://github.com/milesj/emojibase

## License

FortnightUtils is available under the MIT license. See the LICENSE file for more info.
