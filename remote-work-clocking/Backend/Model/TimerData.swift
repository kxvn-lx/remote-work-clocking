//
//  TimerData.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 21/3/2023.
//

import Foundation

struct TimerData: Codable, Hashable {
    let date: Date
    let duration: TimeInterval
    
    static let static_datas: [TimerData] = [
        .init(date: Date(), duration: 23),
        .init(date: Date(), duration: 12.5),
        .init(date: Date(), duration: 123),
        .init(date: Date(), duration: 423),
        .init(date: Date(), duration: 23)
    ]
}
