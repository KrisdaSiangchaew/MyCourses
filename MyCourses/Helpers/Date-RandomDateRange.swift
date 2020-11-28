//
//  Date-RandomDateRange.swift
//  MyCourses
//
//  Created by Kris Siangchaew on 28/11/2563 BE.
//

import Foundation

extension Date {
    static func randomDateWithin(numberOfDays: Int) -> Date {
        let numberOfSeconds = 24*60*60*numberOfDays
        
        return Date(timeIntervalSinceNow: TimeInterval(Int.random(in: 0...numberOfSeconds)))
    }
}
