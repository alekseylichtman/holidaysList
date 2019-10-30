//
//  HolidayRequest.swift
//  Holidays_App
//
//  Created by Oleksii Kolakovskyi on 10/30/19.
//  Copyright © 2019 Aleksey. All rights reserved.
//

import Foundation

enum HolidayError: Error {
    case noDateAvaliable
    case canNotProcessData
}

struct HolidayRequest {
    let resourseURL: URL
    let API_KEY = "260a0d773cd2f847debc8b25717061fd34ddb18a"
    
    init(countryCode: String) {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        let currentYear = format.string(from: date)
        
        let resourseString = "https://calendarific.com/api/v2/holidays?api_key=\(API_KEY)&country=\(countryCode)&year=\(currentYear)"
        guard let resourseURL = URL(string: resourseString) else {fatalError()}
        
        self.resourseURL = resourseURL
    }
    
    func getHolidays(completion: @escaping(Result <[HolidayDetail], HolidayError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourseURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDateAvaliable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let holidaysResponse = try decoder.decode(HolidayResponse.self, from: jsonData)
                let holidayDetails = holidaysResponse.response.holidays
                completion(.success(holidayDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}
