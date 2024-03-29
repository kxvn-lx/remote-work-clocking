//
//  ContentViewModel.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 21/3/2023.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var timerIsRunning = false {
        didSet {
            if timerIsRunning && startDate == nil {
                startDate = Date()
            }
        }
    }
    @Published var elapsedTime: TimeInterval = 0
    @Published var timerDatas = [TimerData]()
    @Published var selectedTag: Tag?
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var cancellables = Set<AnyCancellable>()
    private var startDate: Date? // Placeholder date
    
    
    init() {
        timer
            .filter { [weak self] _ in self?.timerIsRunning ?? false }
            .sink { [weak self] _ in self?.elapsedTime += 1 }
            .store(in: &cancellables)
        
        timerDatas = DBEngine.shared.getDatas()
    }
    
    
    // MARK: PUBLIC METHODS
    
    func getElapsedTimeDescription() -> String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func stopTimer() {
        timerIsRunning = false
        DBEngine
            .shared
            .save(.init(date: startDate ?? Date(), duration: elapsedTime, tag: selectedTag)) { timerDatas in
            self.timerDatas = timerDatas
        }
        
        startDate = nil // reset startDate
        elapsedTime = 0
        selectedTag = nil
    }
    
    func delete(_ datas: [TimerData] ) {
        DBEngine.shared.delete(datas) { timerDatas in
            self.timerDatas = timerDatas
        }
    }
    
    
    // MARK: -- PRIVATE METHODS
}
