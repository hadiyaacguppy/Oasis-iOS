## NSSattributedString init with given Aligment

Returns an `NSAttrbiutedString` object initialized with a given string and an aligment.

As an example, this initilizer can be used to align center the textField placeHolder without changing the normal text aligment.

Example : 

````swift
 yourTextField.attributedPlaceholder = NSAttributedString(text: "First Name",
                                                               aligment: .center)

````

```swift

   convenience init(text: String, aligment: NSTextAlignment) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = aligment
        self.init(string: text, attributes: [NSAttributedStringKey.paragraphStyle: paragraphStyle])
    }

````