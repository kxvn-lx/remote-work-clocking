//
//  ReaderView.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 21/3/2023.
//

import SwiftUI

struct ReaderView: View {
    @State private var selectedItems: Set<TimerData> = []
    @EnvironmentObject private var vm: ContentViewModel
    
    
    var body: some View {
        List(vm.timerDatas, id: \.self, selection: $selectedItems) { timerData in
            VStack(alignment: .leading) {
                Text("\(timerData.getHumanDescription()) mins") // Convert the interval to hours and display as text
                HStack {
                    Text(timerData.getDateComponents().day)
                    Text(timerData.getDateComponents().date)
                    Text(timerData.getDateComponents().time)
                }
                Divider()
            }
        }
        .contextMenu {
            Button(action: {
                guard selectedItems.count > 0 else { return }
                vm.delete(Array(selectedItems))
                selectedItems = []
            }) {
                Text("Delete")
                Image(systemName: "trash")
            }
        }
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ReaderView()
    }
}
