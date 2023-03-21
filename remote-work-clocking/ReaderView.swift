//
//  ReaderView.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 21/3/2023.
//

import SwiftUI

struct ReaderView: View {

    var body: some View {
        List(TimerData.static_datas, id: \.self) { timerData in
            Text("\(timerData.duration / 3600) hours") // Convert the interval to hours and display as text
            Text("\(timerData.date)")
            Divider()
        }
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ReaderView()
    }
}
