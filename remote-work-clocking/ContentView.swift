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
        VStack {
            VStack(spacing: 25) {
                Text(vm.timeString(vm.elapsedTime))
                    .font(.largeTitle)
                
                VStack {
                    Button {
                        vm.timerIsRunning.toggle()
                    } label: {
                        Text(vm.timerIsRunning ? "Pause" : "Clock In")
                    }
                    
                    if vm.timerIsRunning || vm.elapsedTime != 0 {
                        Button {
                            vm.stopTimer()
                        } label: {
                            Text("Stop")
                        }
                        
                    }
                }
            }
            .padding()
            
            ReaderView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
