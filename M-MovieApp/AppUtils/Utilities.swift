//
//  Utilities.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 6.05.2022.
//

import UIKit

class Utilities {
    class func setDate(_ dateString: String?, with format: String) -> String {
        var dateStr = dateString ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.DateFormat.common
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.dateFormat = format
            dateStr = dateFormatter.string(from: date)
        }
        return dateStr
    }
    
    class func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
}
