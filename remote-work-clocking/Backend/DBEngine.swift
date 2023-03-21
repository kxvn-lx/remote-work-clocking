//
//  DBEngine.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 21/3/2023.
//

import Foundation

struct DBEngine {
    static var shared = DBEngine()
    
    private init() {}
    
    struct TimerData: Codable {
        let date: Date
        let duration: TimeInterval
    }
    
    private var timerData: [TimerData] = []
    
    // MARK: - Private Functions
    
    private func saveTimerData() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(timerData)
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("timerData.json")
            try data.write(to: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private mutating func loadTimerData() {
        let decoder = JSONDecoder()
        do {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("timerData.json")
            let data = try Data(contentsOf: url)
            let timerData = try decoder.decode([TimerData].self, from: data)
            self.timerData = timerData
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Public Functions
    
    mutating func addTimerData(date: Date, duration: TimeInterval) {
        let newTimerData = TimerData(date: date, duration: duration)
        timerData.append(newTimerData)
        saveTimerData()
    }
    
    mutating func getTimerData() -> [TimerData] {
        if timerData.isEmpty {
            loadTimerData()
        }
        return timerData
    }
    
}
