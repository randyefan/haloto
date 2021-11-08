//
//  Extension+Double.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 06/11/21.
//

import Foundation

extension Double {
    
    var int: Int {
        return Int(self)
    }
    
    func stringFromTimeInterval(type: TimerType = .short, isShowSecond: Bool = false, isSimplified: Bool = false) -> String {
        guard self.isNaN == false && self.int >= 0 else {
            if type == .digits {
                return "00:00:00"
            } else {
                return isShowSecond ? "\(0) detik" : "\(0) menit"
            }
        }
        let days = self.int / 86400
        let hours = (self.int % 86400) / 3600
        let minutes = (self.int % 3600) / 60
        let seconds = self.int % 60
        
        var textDuration = ""
        var textDays = ""
        var textHours = ""
        var textMinutes = ""
        var textSeconds = ""
        
        switch type {
        case .full:
            textDays = "\(days) day"
            textHours = "\(hours) hour"
            textMinutes = "\(minutes) minute"
            textSeconds = "\(seconds) second"
            
        case .short:
            textDays = "\(days) d"
            textHours = "\(hours) h"
            textMinutes = "\(minutes) m"
            textSeconds = "\(seconds) s"
            
        case .digits:
            textHours = hours < 10 ? "0\(hours)" : "\(hours)"
            textMinutes = minutes < 10 ? "0\(minutes)" :"\(minutes)"
            textSeconds = seconds < 10 ? "0\(seconds)" :"\(seconds)"
        }
        
        // Days
        if days > 0 || !isSimplified {
            textDuration = textDays
        }
        
        // Hours
        if hours > 0 || !isSimplified {
            textDuration = textDuration.isEmpty ? textHours : "\(textDuration) \(textHours)"
        }
        
        // Minutes
        if minutes > 0 || !isSimplified || type == .digits {
            textDuration = textDuration.isEmpty ? textMinutes : "\(textDuration) \(textMinutes)"
        }
        
        // Seconds
        if isShowSecond {
            textDuration = textDuration.isEmpty ? textSeconds : "\(textDuration) \(textSeconds)"
        }
        
        return type == .digits ? textDuration.replacingOccurrences(of: " ", with: ":") : textDuration
    }
}
