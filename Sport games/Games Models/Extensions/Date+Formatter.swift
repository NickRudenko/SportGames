//
//  Date+Formatter.swift
//  Sport games
//
//  Created by Mykola Rudenko on 24.01.2022.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
