//
//  StringExtension.swift
//  Rocket
//
//  Created by Adela Mišicáková on 19.07.2022.
//

import Foundation

extension String {
    
    //MARK: - Formate dateString
    // - Formates dateString from format yyyy-MM-dd to d.M.yyyy
    // - Returns formatted dateString
    
    func formateDateString () -> String {
        let inputDateFormatter = DateFormatter()
        
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        let date = inputDateFormatter.date(from: self)!
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "d.M.yyyy"
        
        return outputDateFormatter.string(from: date)
    }
}
