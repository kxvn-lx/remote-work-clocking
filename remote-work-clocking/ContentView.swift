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
                    NavigationLink(destination: Timer_TagsView().environmentObject(vm), tag: "timerView", selection: $selectedId) {
                        Label("Timer", systemImage: "timer")
                    }
                    NavigationLink(destination: ReaderView().environmentObject(vm), tag: "readerView", selection: $selectedId) {
                        Label("Database", systemImage: vm.timerDatas.count == 0 ? "tray" : "tray.full")
                    }
                }
            }
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { toggleSidebar() }) {
                        Image(systemName: "sidebar.left")
                    }
                }
            }
        }
    }
    
    private func toggleSidebar() {
        #if os(iOS)
        #else
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
