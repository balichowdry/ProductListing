//
//  String+Date.swift
//  Check24
//
//  Created by BilalSattar on 22/09/2018.
//  Copyright © 2018 BilalSattar. All rights reserved.
//

import Foundation

extension String {
    func getFormattedDate(string: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz" // This formate is input formated .
        
        let formateDate = dateFormatter.date(from:"2018-02-02 06:50:16 +0000")!
        dateFormatter.dateFormat = "dd-MM-yyyy" // Output Formated
        
        print ("Print :\(dateFormatter.string(from: formateDate))")//Print :022-09-2018
        return dateFormatter.string(from: formateDate)
    }
}
