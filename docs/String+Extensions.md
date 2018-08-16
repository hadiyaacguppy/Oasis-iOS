


## > urlEscaped
convert the string into url escaped string
```swift
	 var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
```

## > toAttributed
converts a `String` to `NSAttributedString`

```swift 
  	var toAttributed : NSAttributedString {
        return NSAttributedString(string: self)
    }

```


## > inSensitiveCompare
Compares 2 strings ignoring case sensitivity

```swift 
	func inSensitiveCompare(otherString : String) ->Bool {
        return self.caseInsensitiveCompare(otherString) == ComparisonResult.orderedSame
    }

```