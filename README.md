# KOLocalizedString
## Overview
Helper for change language your app, without rebooting  app.

## Usage

1. Copy KOLocalizedString.swift to your project

2. Created in project file "key_Localizable.plist"  key - your language key wth 2 characters

3. add to property list(example: en_Localizable.plist) string Key and string Value

4. Example usage, return value for key. 
```swift
textLabel.text = KOLocalized(key:"key")
//Recommended usage in updated functions viewDidAppear
```
5. Example Usage change Localized
```swift
KOLocalizedClass.instanc.changeLocalized(key: "en")
```
