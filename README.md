# KOLocalizedString
## Overview
Helper for change language your app, without rebooting  app.

## Usage

1. Copy KOLocalizedString.swift to your project

2. add to AppDelegate "KOLocalizedSettings"  
```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        KOLocalizedSettings(nameFile: nil, appLocaleList: ["en","ru"], defaultLocale: "en", localeDevice: false)
        return true
}
```
Created in project file "key_nameFile.plist"  
   key - your language key wth 2 characters
   nameFile - your base name file. if nameFile nil, default value "Localizable"

Example usage, return value for key. 
```swift
textLabel.text = KOLocalized("key")
//Recommended usage in updated functions viewDidAppear
```
Example Usage change Localized
```swift
KOLocalizedChangeLocale("en")
```
## Optional

Current language key
```swift
public func KOLocalizedCurrentLocale()->String
```
