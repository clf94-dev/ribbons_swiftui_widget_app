//
//  IntentHandler.swift
//  MediumWidgetIntentHandler
//
//  Created by Carmen Lucas on 9/7/23.
//

import Intents

class IntentHandler: INExtension, MediumChoiceConfigIntentHandling {
    func provideSelectedRibbon1OptionsCollection(for intent: MediumChoiceConfigIntent, with completion: @escaping (INObjectCollection<SmallChoice>?, Error?) -> Void) {
        let choices = RibbonsDataStore().ribbons.map { ribbon in
            SmallChoice(identifier: ribbon.id, display: ribbon.title)
            
        }
        let collection = INObjectCollection(items: choices)
        completion(collection, nil)
    }
    

    func provideSelectedRibbon2OptionsCollection(for intent: MediumChoiceConfigIntent, with completion: @escaping (INObjectCollection<SmallChoice2>?, Error?) -> Void) {
        let choices = RibbonsDataStore().ribbons.map { ribbon in
            SmallChoice2(identifier: ribbon.id, display: ribbon.title)
            
        }
        let collection = INObjectCollection(items: choices)
        completion(collection, nil)
    }
    
    
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
