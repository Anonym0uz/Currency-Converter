//
//  RootModel.swift
//  CurrencyConverter
//
//  Created by sot on 17.02.2021.
//

import Foundation

struct RootModel: Codable {
    var disclaimer: String?
    var date: String?
    var timestamp: Float?
    var base: String?
    var rates: [String : Double]?
    
    enum CodingKeys: String, CodingKey {
        case disclaimer
        case date
        case timestamp
        case base
        case rates
    }
}

//extension RootModel {
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.disclaimer = try container.decode(String.self, forKey: .disclaimer)
//        self.date = try container.decode(String.self, forKey: .date)
//        self.timestamp = try container.decode(Float.self, forKey: .timestamp)
//        self.base = try container.decode(String.self, forKey: .base)
//        self.rates = try container.decode([String : Double].self, forKey: .rates)
//    }
//}

struct RootModel2: Codable {
    var date: String?
    var previousDate: String?
    var previousURL: String?
    var timestamp: String?
    var valute: [String : CurrencyModel]?
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case previousDate = "PreviousDate"
        case previousURL = "PreviousURL"
        case timestamp = "Timestamp"
        case valute = "Valute"
    }
}
