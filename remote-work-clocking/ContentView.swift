//
//  ContentView.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 21/3/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ContentViewModel()
    @State private var showDialog = false
    
    var body: some View {
        VStack {
            VStack(spacing: 25) {
                Text(vm.getElapsedTimeDescription())
                    .font(.largeTitle)
                
                VStack {
                    Button {
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
                                vm.timerIsRunning = true
                            })
                        }
                    }
                }
            }
            .padding()
            
            ReaderView()
                .environmentObject(vm)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
