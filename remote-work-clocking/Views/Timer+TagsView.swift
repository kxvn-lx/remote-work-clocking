//
//  Timer+TagsView.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 23/3/2023.
//

import SwiftUI

struct Timer_TagsView: View {
    
    var body: some View {
        VStack {
            TimerView()
            TagsView()
        }
    }
}

struct Timer_TagsView_Previews: PreviewProvider {
    static var previews: some View {
        Timer_TagsView().environmentObject(ContentViewModel())
    }
}
