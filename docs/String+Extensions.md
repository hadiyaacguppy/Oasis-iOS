


## urlEscaped
convert the string into url escaped string
```swift
 var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
```