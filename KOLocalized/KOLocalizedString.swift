//
//  KOLocalizedString.swift
//
//  Created by Oleksandr Khymych on 24.09.16.
//  Copyright © 2016 com.khymych. All rights reserved.
//

//Example usage return value for key
//Recomend usage in update func viewDidAppear
/*
 textLabel.text = KOLocalized(key:"key")
 */

//Example Usage change Localized
/*
 KOLocalizedClass.instanc.changeLocalized(key: "en")
 */

//Created in project file "key_Localizable.plist"  key - your language key wth 2 characters
/*
 <key>stringKey</key>
	<string>stringValue</string>
 
 */

import Foundation

func KOLocalized(key:String)->String{
    return KOLocalizedClass.instanc.valueWith(key: key)
}

class KOLocalizedClass: NSObject {
    static let instanc = KOLocalizedClass()

    private let localeArray : Array  = ["ru","en"]
    private let keyLocale   : String = "kLocale"
    private let endNameFile : String = "Localizable"

    private var localeDictionary : NSDictionary!
    private let typeLocalizable  : String = "plist"
    private var nameFile         : String!

    override init() {
        super.init()
        checkFirstInit()
    }
    //MARK: Public Methods
    public func changeLocalized(key:String){
        UserDefaults.standard.set("\(key)_\(endNameFile)", forKey: keyLocale)
        nameFile = "\(key)_\(endNameFile)"
        updateDictionary()
    }

    //MARK: Internal Methods
    internal func valueWith(key:String) -> String {
        var value:String
        value = localeDictionary.object(forKey: key) as? String ?? key
        return value
    }

    //MARK: Privat Methods
    private func checkFirstInit(){
        if UserDefaults.standard.object(forKey: keyLocale) == nil{
            var langValue:String {
                var langValue:String {
                let locale : String = self.systemLocale()
                
                for localeString in localeArray{
                    if localeString == locale{
                        return localeString != "" ? locale : "en"
                    }
                }
                return locale != "" ? locale : "en"
            }
            UserDefaults.standard.set("\(langValue)_\(endNameFile)", forKey: keyLocale)
            nameFile = "\(langValue)_\(endNameFile)"
        }else{
            nameFile = UserDefaults.standard.object(forKey: keyLocale) as! String
        }
        updateDictionary()
    }

    //Update Dictionary
    private func updateDictionary(){
        if let path =  Bundle.main.path(forResource: nameFile, ofType: typeLocalizable) {
            localeDictionary = NSDictionary(contentsOfFile: path)!
        }
    }
	    //Change locale from default value
    func defaultLocale(){
        self.changeLocalized(key: systemLocale())
    }
    
    //locale device
    private func systemLocale()-> String {
        var systemLocale : String = NSLocale.preferredLanguages[0]
        
        if systemLocale.characters.count > 2 {
            let index = systemLocale.range(of: "-")?.lowerBound
            systemLocale = systemLocale.substring(to: index!)
        }
        return systemLocale
    }
}
