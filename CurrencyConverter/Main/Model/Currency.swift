//
//  Currency.swift
//  CurrencyConverter
//
//  Created by sot on 16.02.2021.
//

import Foundation
import UIKit

struct RootModel {
    var Date: String?
    var PreviousDate: String?
    var PreviousURL: String?
    var Timestamp: String?
    var Valute: [CurrencyModel]?
}

struct CurrencyModel {
    var ID: String?
    var NumCode: String?
    var CharCode: String?
    var Nominal: String?
    var Name: String?
    var Value: String?
    var Previous: String?
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
