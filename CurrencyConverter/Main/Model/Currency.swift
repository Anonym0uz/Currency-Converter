//
//  Currency.swift
//  CurrencyConverter
//
//  Created by sot on 16.02.2021.
//

import Foundation

struct CurrencyModel: Codable {
    var id: String?
    var numCode: String?
    var charCode: String?
    var nominal: Int?
    var name: String?
    var value: Double?
    var previous: Double?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case numCode = "NumCode"
        case charCode = "CharCode"
        case nominal = "Nominal"
        case name = "Name"
        case value = "Value"
        case previous = "Previous"
    }
}

//{
//    "Date\": \"2021-02-17T11:30:00+03:00\",
//    \"PreviousDate\": \"2021-02-16T11:30:00+03:00\",
//    \"PreviousURL\": \"\\/\\/www.cbr-xml-daily.ru\\/archive\\/2021\\/02\\/16\\/daily_json.js\",
//    \"Timestamp\": \"2021-02-16T18:00:00+03:00\",
//    \"Valute\":
//    "AUD" : {
//    \"ID\": \"R01010\",
//    \"NumCode\": \"036\",
//    \"CharCode\": \"AUD\",
//    \"Nominal\": 1,
//    \"Name\": \"Австралийский доллар\",
//    \"Value\": 57.0559,
//    \"Previous\": 57.0639
//  }
//}
