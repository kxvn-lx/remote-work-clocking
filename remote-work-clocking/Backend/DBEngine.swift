//
//  DBEngine.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 21/3/2023.
//

import Foundation
import Combine

struct DBEngine {
    static var shared = DBEngine()
    private var timerDatas: [TimerData] = []
    
    private init() {fetchFromDB(newTimerDatas: nil)}
    
    // MARK: Public Functions
    
    mutating func save(_ timerData: TimerData, results newDatas: (([TimerData]) -> Void)?) {
        if timerDatas.contains(timerData) {
            timerDatas.removeAll(where: { $0 == timerData })
        } else {
            timerDatas.append(timerData)
        }
        
        saveToDB()
        timerDatas = timerDatas.sorted(by: { $0.date > $1.date })
        
        newDatas?(timerDatas)
    }
    
    mutating func delete(_ timerData: TimerData, results newTimerData: (([TimerData]) -> Void)?) {
        timerDatas.removeAll(where: { $0 == timerData })
        
        saveToDB()
        timerDatas = timerDatas.sorted(by: { $0.date > $1.date })
        
        newTimerData?(timerDatas)
    }
    
    func getDatas() -> [TimerData] {
        return self.timerDatas
    }
    
    
    // MARK: - Private Functions
    
    private func saveToDB() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(timerDatas)
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("timerData.json")
            try data.write(to: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private mutating func fetchFromDB(newTimerDatas: (([TimerData]) -> Void)?) {
        let decoder = JSONDecoder()
        do {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("timerData.json")
            let data = try Data(contentsOf: url)
            let timerDatas = try decoder.decode([TimerData].self, from: data)
            self.timerDatas = timerDatas.sorted(by: { $0.date > $1.date })
        } catch {
            print(error.localizedDescription)
        }
        newTimerDatas?(timerDatas)
    }
    
}
