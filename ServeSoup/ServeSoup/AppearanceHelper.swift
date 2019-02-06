//
//  AppearanceHelper.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/6/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation
import UIKit

enum AppearanceHelper {
    
    static var honeydew = UIColor(red: 239/255, green: 249/255, blue: 240/255, alpha: 1.0)
    static var queenBlue = UIColor(red: 53/255, green: 103/255, blue: 153/255, alpha: 1.0)
    static var seaGreen = UIColor(red: 46/255, green: 150/255, blue: 79/255, alpha: 1.0)
    static var gunmetal = UIColor(red: 48/255, green: 50/255, blue: 61/255, alpha: 1.0)
    static var spanishGray = UIColor(red: 152/255, green: 151/255, blue: 136/255, alpha: 1.0)
    
    static func sansFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        let font = UIFont(name: "PT Sans", size: pointSize)!
        
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
        
    }
    
    static func setAppearance() {
        
        let textAttributes = [NSAttributedString.Key.font: sansFont(with: .largeTitle, pointSize: 90), NSAttributedString.Key.foregroundColor: queenBlue]
        
        
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
        
        UINavigationBar.appearance().barTintColor = spanishGray
        UIBarButtonItem.appearance().tintColor = queenBlue
        
        UITextField.appearance().tintColor = seaGreen
        
        
    }
    
    static func style(button: UIButton) {
       // button.titleLabel?.font = typerighterFont(with: .callout, pointSize: 30)
        button.setTitleColor(honeydew, for: .normal)
        button.backgroundColor = spanishGray
        button.layer.cornerRadius = 3
    }
    
}
