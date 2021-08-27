//
//  Date+Extension.swift
//  Weather
//
//  Created by MAC on 27/08/21.
//

import Foundation

extension Date {
    func getDate(milliSec:Int)-> String {
        let date = Date(timeIntervalSince1970: (Double(milliSec) ))
        return date.getString()
    }
    func getHr(milliSec:Int)-> String {
        let date = Date(timeIntervalSince1970: (Double(milliSec) ))
        return date.getHrString()
    }
    
    func getString()->String {

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "EEEE-MM/dd/YYYY"

        // Convert Date to String
      return dateFormatter.string(from: self)
    }
    func getHrString()->String {

        // Create Date Formatter
        let dateFormatter = DateFormatter()

        // Set Date Format
        dateFormatter.dateFormat = "hh:mm"

        // Convert Date to String
      return dateFormatter.string(from: self)
    }
}
