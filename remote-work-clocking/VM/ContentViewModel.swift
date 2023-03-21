//
//  ContentViewModel.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 21/3/2023.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var timerIsRunning = false
    @Published private(set) var elapsedTime: TimeInterval = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var timerDatas = [TimerData]()
    private var cancellables = Set<AnyCancellable>()
    
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
        DBEngine.shared.save(.init(date: Date(), duration: elapsedTime)) { timerDatas in
            self.timerDatas = timerDatas
        }

        elapsedTime = 0
    }
    
    func delete(_ data: TimerData ) {
        DBEngine.shared.delete(data) { timerDatas in
            self.timerDatas = timerDatas
        }
    }
    
    
    // MARK: -- PRIVATE METHODS
}
