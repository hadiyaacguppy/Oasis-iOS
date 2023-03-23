//
//  LanguageService.swift
//  Oasis
//
//  Created by Wassim on 11/9/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation

enum Languages:String {
    case arabic = "ar"
    case english = "en"
//    case Afar
//    case Abkhazian
//    case Afrikaans
//    case Akan
//    case Amharic
//    case Aragonese
//    case Arabic
//    case Assamese
//    case Avar
//    case Aymara
//    case Azerbaijani
//    case Bashkir
//    case Belarusian
//    case Bulgarian
//    case Bihari
//    case Bislama
//    case Bambara
//    case Bengali
//    case Tibetan
//    case Breton
//    case Bosnian
//    case Catalan
//    case Chechen
//    case Chamorro
//    case Corsican
//    case Cree
//    case Czech
//    case OldChurchSlavonic
//    case Chuvash
//    case Welsh
//    case Danish
//    case German
//    case Divehi
//    case Dzongkha
//    case Ewe
//    case Greek
//    case English
//    case Esperanto
//    case Spanish
//    case Estonian
//    case Basque
//    case Persian
//    case Peul
//    case Finnish
//    case Fijian
//    case Faroese
//    case French
//    case WestFrisian
//    case Irish
//    case ScottishGaelic
//    case Galician
//    case Guarani
//    case Gujarati
//    case Manx
//    case Hausa
//    case Hindi
//    case HiriMotu
//    case Croatian
//    case Haitian
//    case Hungarian
//    case Armenian
//    case Herero
//    case Interlingua
//    case Indonesian
//    case Interlingue
//    case Igbo
//    case SichuanYi
//    case Inupiak
//    case Ido
//    case Icelandic
//    case Italian
//    case Inuktitut
//    case Japanese
//    case Javanese
//    case Georgian
//    case Kongo
//    case Kikuyu
//    case Kuanyama
//    case Kazakh
//    case Greenlandic
//    case Cambodian
//    case Kannada
//    case Korean
//    case Kanuri
//    case Kashmiri
//    case Kurdish
//    case Komi
//    case Cornish
//    case Kirghiz
//    case Latin
//    case Luxembourgish
//    case Ganda
//    case Limburgian
//    case Lingala
//    case Laotian
//    case Lithuanian
//    case LubaKatanga
//    case Latvian
//    case Malagasy
//    case Marshallese
//    case Maori
//    case Macedonian
//    case Malayalam
//    case Mongolian
//    case Moldovan
//    case Marathi
//    case Malay
//    case Maltese
//    case Burmese
//    case Nauruan
//    case NorwegianBokmål
//    case NorthNdebele
//    case Nepali
//    case Ndonga
//    case Dutch
//    case NorwegianNynorsk
//    case Norwegian
//    case SouthNdebele
//    case Navajo
//    case Chichewa
//    case Occitan
//    case Ojibwa
//    case Oromo
//    case Oriya
//    case Ossetian
//    case Panjabi
//    case Pali
//    case Polish
//    case Pashto
//    case Portuguese
//    case Quechua
//    case RaetoRomance
//    case Kirundi
//    case Romanian
//    case Russian
//    case Rwandi
//    case Sanskrit
//    case Sardinian
//    case Sindhi
//    case NorthernSami
//    case Sango
//    case SerboCroatian
//    case Sinhalese
//    case Slovak
//    case Slovenian
//    case Samoan
//    case Shona
//    case Somalia
//    case Albanian
//    case Serbian
//    case Swati
//    case SouthernSotho
//    case Sundanese
//    case Swedish
//    case Swahili
//    case Tamil
//    case Telugu
//    case Tajik
//    case Thai
//    case Tigrinya
//    case Turkmen
//    case TagalogFilipino
//    case Tswana
//    case Tonga
//    case Turkish
//    case Tsonga
//    case Tatar
//    case Twi
//    case Tahitian
//    case Uyghur
//    case Ukrainian
//    case Urdu
//    case Uzbek
//    case Venda
//    case Vietnamese
//    case Volapük
//    case Walloon
//    case Wolof
//    case Xhosa
//    case Yiddish
//    case Yoruba
//    case Zhuang
//    case Chinese
//    case Zulu
}

class LanguageService {
    
    var rtlLanguages : [Languages] = [.arabic]
    
    static let current = LanguageService()
    
    fileprivate var dl = Locale.current.languageCode
    
    var deviceLang : Languages{
        guard let dl = dl else {
            return .english
        }
        switch true {
        case dl.contains(Languages.arabic.rawValue):
            return .arabic
        case dl.contains(Languages.english.rawValue):
            return .english
        default :
            return .english
        }
    }
    
    var isRTL : Bool{
        return rtlLanguages.contains(deviceLang)
    }
}
