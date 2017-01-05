//
//  KOLocalizedString.swift
//
//  Created by Oleksandr Khymych on 24.09.16.
//  Copyright © 2016 com.khymych. All rights reserved.
//
import Foundation
import UIKit

/// Returns a localized string
///
/// - Parameter key: key for value
/// - Returns: return value or key if not found key in dictionary
public func KOLocalized(_ key:String)->String{
    return KOLocalizedClass.instance.valueWith(key: key)
}
/// Base settings for KOLocalizedClass class
///
/// - Parameters:
///   - nameFile: name file, default "Localizable". full name file key_Localizable -- prefix locale "key_" and name file "Localizable"
///   - appLocaleList: array string value keys language - only string two symbols lenghts
///   - defaultLocale: default language app, default "en"
public func KOLocalizedSettings(nameFile:String?, appLocaleList:Array<String>, defaultLocale: String, localeDevice:Bool){
    KOLocalizedClass.instance.initSettings(nameFile: nameFile, array: appLocaleList, defaultLocale: defaultLocale)
    if localeDevice {
        KOLocalizedClass.instance.defaultLocale()
    }
}
/// Current locale
///
/// - Returns: return current locale
public func KOLocalizedCurrentLocale()->String{
    return KOLocalizedClass.instance.currentLocale()
}
/// Current locale
///
/// - Returns: return current locale
public func KOLocalizedCurrentLocaleForWeb()->String{
    return KOLocalizedClass.instance.currentLocaleForWeb()
}
/// Change Language
///
/// - Parameter key: key language
public func KOLocalizedChangeLocale(key:String){
    KOLocalizedClass.instance.changeLocalizedWithKey(key)
}

///Example usage return value for key
///Recomend usage in update func viewDidAppear
///textLabel.text = KOLocalized(key:"key")
///
///Example Usage change Localized
///KOLocalizedClass.instanc.changeLocalized(key: "en")
/// Created in project file "key_Localizable.plist"  key - your language key wth 2 characters
open class KOLocalizedClass: NSObject {
    static fileprivate let instance = KOLocalizedClass()
    
    private var localeArray         : Array  = ["en"]
    private var defLocaleValue      : String  = "en"
    
    private let keyLocale           : String = "kLocaleDic"
    private var endNameFile         : String = "Localizable"
    
    private var localeDictionary    : NSDictionary!
    private let typeLocalizable     : String = "plist"
    private var nameFile            : String!{
        didSet{
            updateDictionary()
        }
    }
    /// Public function Change localized
    ///
    /// - Parameter key: key localized for  language change in app
    fileprivate func changeLocalizedWithKey(_ key:String){
        UserDefaults.standard.set(["languageKey": key, "nameFile":"\(key)_\(endNameFile)"], forKey: keyLocale)
        nameFile = "\(key)_\(endNameFile)"
        for localeString in localeArray{
            if localeString == key{
                defLocaleValue = key
                return
            }
        }
    }
    /// init base settings
    ///
    /// - Parameters:
    ///   - nameFile: name file, default "Localizable". full name file en_Localizable -- prefix locale "en_" and name file "Localizable"
    ///   - array: array string value keys language - only string two symbols lenghts
    ///   - defaultLocale: default language app
    fileprivate func initSettings(nameFile:String?, array:Array<String>, defaultLocale: String){
        endNameFile = nameFile ?? endNameFile
        guard localeArray == array else {
            for key:String in array{
                guard key.characters.count == 2 else {
                    return
                }
                defLocaleValue =  defaultLocale == key ? defaultLocale : defLocaleValue
            }
            localeArray = array
            checkFirstInit()
            return
        }
        checkFirstInit()
    }
    /// Get value by key. if key not found return key as value
    ///
    /// - Parameter key: key for search value in dictionary
    /// - Returns: return value or key if not found key in dictionary
    fileprivate func valueWith(key:String) -> String {
        if (localeDictionary != nil) {
            return localeDictionary.object(forKey: key) as? String ?? key
        }else{
            return key
        }
    }
    /// Main function
    private func checkFirstInit(){
        if UserDefaults.standard.object(forKey: keyLocale) == nil{
            var langValue:String {
                let locale : String = self.systemLocale()
                
                for localeString in localeArray{
                    if localeString == locale{
                        return localeString != "" ? locale : defLocaleValue
                    }
                }
                return defLocaleValue
            }
            UserDefaults.standard.set(["languageKey": langValue, "nameFile":"\(langValue)_\(endNameFile)"], forKey: keyLocale)
            nameFile = "\(langValue)_\(endNameFile)"
            defLocaleValue = langValue
        }else{
            let dic = UserDefaults.standard.object(forKey: keyLocale) as! Dictionary<String, Any>
            nameFile = dic["nameFile"] as! String
            defLocaleValue = dic["languageKey"] as! String
        }
        updateDictionary()
    }
    
    /// Update Dictionary
    private func updateDictionary(){
        if let path =  Bundle.main.path(forResource: nameFile, ofType: typeLocalizable) {
            localeDictionary = NSDictionary(contentsOfFile: path)!
        }
    }
    /// Change locale from default value
    fileprivate func defaultLocale(){
        for localeString in localeArray{
            if localeString == systemLocale(){
                defLocaleValue = localeString
                self.changeLocalizedWithKey(localeString)
                return
            }
        }
        self.changeLocalizedWithKey(defLocaleValue)
    }
    /// Current locale
    ///
    /// - Returns: return key current language
    fileprivate func currentLocale() -> String {
        return defLocaleValue
    }
    /// Current locale for web
    ///
    /// - Returns: return key current language
    fileprivate func currentLocaleForWeb() -> String {
        return defLocaleValue == "uk" ?  "ua" : defLocaleValue
    }
    
    /// locale device
    private func systemLocale()-> String {
        var systemLocale : String = NSLocale.preferredLanguages[0]
        
        if systemLocale.characters.count > 2 {
            let index = systemLocale.range(of: "-")?.lowerBound
            systemLocale = systemLocale.substring(to: index!)
        }
        return systemLocale
    }
    
}

extension UILabel {
    @IBInspectable  var localizedText: String {
        set (key) {
            text = KOLocalized(key)
        }
        get {
            return text!
        }
    }
}
