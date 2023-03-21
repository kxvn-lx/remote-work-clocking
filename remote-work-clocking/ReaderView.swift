//
//  ReaderView.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 21/3/2023.
//

import SwiftUI

struct ReaderView: View {

    var body: some View {
        List(DBEngine.shared.getTimerData(), id: \.self) { timerData in
            Text("\(timerData.getHumanDescription()) mins") // Convert the interval to hours and display as text
            HStack {
                Text(timerData.getDateComponents().day)
                Text(timerData.getDateComponents().date)
                Text(timerData.getDateComponents().time)
            }
            Divider()
        }
    }
}

struct ReaderView_Previews: PreviewProvider {
    static var previews: some View {
        ReaderView()
    }
}
