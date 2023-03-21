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
    
    func getHumanDescription() -> String {
        let doubleStr = String(format: "%.2f", duration / 60)
        return doubleStr
    }
    
    func getDateComponents() -> (day: String, time: String, date: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let day = dateFormatter.string(from: self.date)
        
        dateFormatter.dateFormat = "h:mm a"
        let time = dateFormatter.string(from: self.date)
        
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = dateFormatter.string(from: self.date)
        
        return (day, time, dateString)
    }
    
    static let static_datas: [TimerData] = [
        .init(date: Date(), duration: 23),
        .init(date: Date(), duration: 12.5),
        .init(date: Date(), duration: 123),
        .init(date: Date(), duration: 423),
        .init(date: Date(), duration: 23)
    ]
}
