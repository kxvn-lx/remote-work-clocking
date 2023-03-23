//
//  TimerView.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 22/3/2023.
//

import SwiftUI

struct TimerView: View {
    @EnvironmentObject private var vm: ContentViewModel
    @State private var showDialog = false
    
    var body: some View {
        VStack(spacing: 25) {
            Text(vm.getElapsedTimeDescription())
                .font(.largeTitle)
            
            VStack {
                Button { // Clock In || Pause Button
                    vm.timerIsRunning.toggle()
                } label: {
                    Text(vm.timerIsRunning ? "Pause" : "Clock In")
                }
                
                if vm.timerIsRunning || vm.elapsedTime != 0 {
                    Button {
                        vm.timerIsRunning = false
                        showDialog.toggle()
                    } label: {
                        Text("Stop")
                    }
                    .confirmationDialog("Are you sure?", isPresented: $showDialog) {
                        Button("Stop the timer.", role: .destructive) {
                            vm.stopTimer()
                        }
                        Button("Cancel", role: .cancel, action: {
                            vm.elapsedTime = 0
                        })
                    }
                }
            }
        }
        .padding()
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
