//
//  PreferenceManager.swift
//  RaiseMan
//
//  Created by Trever Shick on 10/16/16.
//  Copyright © 2016 Trever Shick. All rights reserved.
//

import Cocoa

class PreferenceManager {
    private let activeVoiceKey = "activeVoice"
    private let activeTextKey = "activeText"
    
    private let defaults = UserDefaults.standard
    
    var activeVoice : String? {
        get {
            return defaults.string(forKey: activeVoiceKey)
        }
        set (v) {
            defaults.set(v, forKey: activeVoiceKey)
        }
    }
    
    var activeText : String? {
        get {
            return defaults.string(forKey: activeTextKey)
        }
        set (v) {
            defaults.set(v, forKey: activeTextKey)
        }
    }
    
    init() {
        registerDefaults()
    }
    
    func registerDefaults() {
        let defaultValues = [
            activeVoiceKey: NSSpeechSynthesizer.defaultVoice(),
            activeTextKey : "This is the default text"
        ]
        defaults.register(defaults: defaultValues)
    }
    
}
