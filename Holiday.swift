//
//  Holiday.swift
//  Holidays_App
//
//  Created by Oleksii Kolakovskyi on 10/30/19.
//  Copyright © 2019 Aleksey. All rights reserved.
//

import Foundation

struct HolidayResponse: Decodable {
    var response: Holidays
}

struct Holidays: Decodable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Decodable {
    var name: String
    var date: DateInfo
}

struct DateInfo: Decodable{
    var iso: String
}
