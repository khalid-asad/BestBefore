//
//  StringKey.swift
//  BestBefore
//
//  Created by Khalid Asad on 11/10/19.
//  Copyright © 2019 Khalid Asad. All rights reserved.
//

import Foundation

enum Language {
    case fr
    case en
}

public enum StringKey: String {
    case error = "Error: "
    case invalidExpiryTitle = "Invalid Expiry Date!"
    case invalidExpiryMessage = "This item is already expired or has an invalid expiry date."
    case itemsTabTitle = "Items"
    case addItemTitle = "Add Item"
    case addItemSubtitle = "Please enter the name and expiry date of the item."
    case addActionTitle = "Add"
    case cancelTitle = "Cancel"
    case addItemTextFieldPlaceholder1 = "Name"
    case addItemTextFieldPlaceholder2 = "Expiry Date"
    case addMoreText = "Add More"
    case baseURL = "https://gist.github.com/khalid-asad/"
    case itemJSONPath = "726740e12caa39c1f71d49a2c5503e06/raw/86bb875bafaeffe3dccb26c34667711bba813d18/items.json"
    
    var language: Language {
        if Locale.preferredLanguages[0].starts(with: "fr") {
            return .fr
        } else {
            return .en
        }
    }
    
    public var localized: String {
        switch language {
        case .fr:
            switch self {
            case .error: return "Erreur"
            case .invalidExpiryTitle: return "Date d'expiration invalide!"
            case .invalidExpiryMessage: return "Cet article a déjà expiré ou a une date d'expiration invalide."
            case .itemsTabTitle: return "Articles"
            case .addItemTitle: return "Ajouter un item"
            case .addItemSubtitle: return "Veuillez entrer le nom et la date d'expiration de l'article."
            case .addActionTitle: return "Ajouter"
            case .cancelTitle: return "Annuler"
            case .addItemTextFieldPlaceholder1: return "Nom"
            case .addItemTextFieldPlaceholder2: return "Date d'expiration"
            case .addMoreText: return "Ajouter Plus De"
            case .baseURL: return "https://gist.github.com/khalid-asad/"
            case .itemJSONPath: return "726740e12caa39c1f71d49a2c5503e06/raw/86bb875bafaeffe3dccb26c34667711bba813d18/items.json"
            }
        default:
            return self.rawValue
        }
    }
}
