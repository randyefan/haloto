//
//  OTPGenerator.swift
//  Haloto
//
//  Created by darindra.khadifa on 11/11/21.
//

import Foundation

class OTPGenerator {

    // MARK: - Common Functions
    static let shared = OTPGenerator()
    private init() { }

    func getOTP() -> String {
        var result = ""
        repeat {
            result = String(format: "%04d", arc4random_uniform(10000))
        } while result.count < 4 || Int(result)! < 1000
        return result
    }
}
