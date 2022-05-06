//
//  Constants.swift
//  M-MovieApp
//
//  Created by Bahadır Enes Atay on 6.05.2022.
//

import UIKit

class Constants {
    enum Height {
        static let upcomingCellHeight: CGFloat = 136
        static let nowPlayingCellHeight: CGFloat = UIScreen.main.bounds.size.height*(256/812)
    }
    
    enum Gap {
        static let small: CGFloat = 4
        static let medium: CGFloat = small * 2
        static let large: CGFloat = medium * 2
    }

    enum DateFormat {
        static let year = "yyyy"
        static let common = "yyyy-MM-dd"
        static let full = "dd.MM.yyyy"
    }
    
    enum Color {
         static let textGray = UIColor(red: 141/255, green: 153/255, blue: 174/255, alpha: 1)
        static let textBlack = UIColor(red: 43/255, green: 45/255, blue: 66/255, alpha: 1)
        static let darkGray = UIColor(red: 173/255, green: 181/255, blue: 189/255, alpha: 1)
        static let darkYellow = UIColor(red: 230/255, green: 185/255, blue: 30/255, alpha: 1)
    }
    
    enum Font {
        case bold(CGFloat)
        case medium(CGFloat)
        case regular(CGFloat)
        var font: UIFont {
            switch self {
            case .bold(let size): return UIFont.systemFont(ofSize: size, weight: .bold)
            case .medium(let size): return UIFont.systemFont(ofSize: size, weight: .medium)
            case .regular(let size): return UIFont.systemFont(ofSize: size, weight: .regular)
            }
        }
    }
    
    enum Icon: String {
        case back_arrow_icon = "back_arrow_icon"
        case arrow_icon = "arrow_icon"
        case rate_icon = "rate_icon"
        case imdb_logo = "imdb_logo"
    }
    
    enum StringFormat {
        static let titleFormatWithDate = "%@ (%@)"
    }
    
    enum Error {
        case noNetwork
        
        var message: String {
            switch self {
            case .noNetwork:
                return "Check your internet connection!"
            }
        }
    }
    
    enum Text: String {
        case internetConnectionMonitor = "InternetConnectionMonitor"
    }
}
