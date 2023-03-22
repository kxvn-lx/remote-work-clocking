//
//  ContentView.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 21/3/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ContentViewModel()
    @State private var selectedId: String? = "timerView"
    
    var body: some View {
        NavigationView {
            List {
                Section("Services") {
                    NavigationLink(destination: TimerView().environmentObject(vm), tag: "timerView", selection: $selectedId) {
                        Label("Timer", systemImage: "timer")
                    }
                    NavigationLink(destination: ReaderView().environmentObject(vm), tag: "readerView", selection: $selectedId) {
                        Label("Database", systemImage: vm.timerDatas.count == 0 ? "tray" : "tray.full")
                    }
                }
            }
            .listStyle(.sidebar)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
