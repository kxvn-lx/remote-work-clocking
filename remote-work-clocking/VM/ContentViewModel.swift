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
    @Published var elapsedTime: TimeInterval = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
        timer
            .filter { [weak self] _ in self?.timerIsRunning ?? false }
            .sink { [weak self] _ in self?.elapsedTime += 1 }
            .store(in: &cancellables)
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    func timeString(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func stopTimer() {
        timerIsRunning = false
        DBEngine.shared.addTimerData(date: Date(), duration: elapsedTime)
        
        elapsedTime = 0
    }
    
    
    // MARK: -- PRIVATE METHODS
}
