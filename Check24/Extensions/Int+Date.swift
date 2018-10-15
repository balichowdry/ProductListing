//
//  Int+Date.swift
//  Check24
//
//  Created by BilalSattar on 22/09/2018.
//  Copyright © 2018 BilalSattar. All rights reserved.
//

import Foundation

extension Int {
    func getDateStringFromUnixTime(dateStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(self)))
    }
}
