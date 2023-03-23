//
//  TimerData.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 21/3/2023.
//

import Foundation

struct Tag: Codable, Hashable, Equatable {
    let title: String
    let emoji: String
    
    static let default_tags: [Tag] = [
        .init(title: "Esper", emoji: "🚀"),
        .init(title: "Personal", emoji: "🌾"),
        .init(title: "Work", emoji: "⚡️"),
    ]
}

struct TimerData: Codable, Hashable, Identifiable, Equatable {
    var id = UUID()
    let date: Date
    let duration: TimeInterval
    let tag: Tag?
    
    init(id: UUID = UUID(), date: Date, duration: TimeInterval, tag: Tag? = nil) {
        self.id = id
        self.date = date
        self.duration = duration
        self.tag = tag
    }
    
    
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

}
