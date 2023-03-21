//
//  ContentView.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 21/3/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var vm = ContentViewModel()
    
    var body: some View {
        VStack(spacing: 25) {
            Text(vm.timeString(vm.elapsedTime))
                .font(.largeTitle)
            
            VStack {
                MainButton(title: vm.timerIsRunning ? "Pause" : "Clock In", longPressAction: {
                    vm.stopTimer()
                }, tapAction: {
                    vm.timerIsRunning.toggle()
                })
                .frame(width: 150)
                
                Text(vm.timerIsRunning ? "Hold down to stop." : "")
                    .font(.caption)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
