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

    func getOTP() -> (code: String, message: String) {
        var result = ""
        repeat {
            result = String(format: "%04d", arc4random_uniform(10000))
        } while result.count < 4 || Int(result)! < 1000

        let message = "Use \(result) as OTP to log in to your Haloto account. NEVER SHARE OTP with anyone. Not even Haloto."
        return (result, message)
    }
}
