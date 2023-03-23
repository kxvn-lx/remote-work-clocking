//
//  TagsView.swift
//  remote-work-clocking
//
//  Created by Kevin Laminto on 23/3/2023.
//

import SwiftUI

struct TagsView: View {
    @EnvironmentObject private var vm: ContentViewModel
    
    var body: some View {
        List {
            Section(header: Text("Tags")) {
                ForEach(Tag.default_tags, id: \.self) { tag in
                    HStack {
                        Label {
                            Text(tag.title)
                        } icon: {
                            Text(tag.emoji)
                        }
                        .font(.caption2)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        .background(Color.gray.opacity(0.25))
                        .cornerRadius(7)
                        
                        Spacer()
                        
                        if vm.selectedTag == tag {
                            Image(systemName: "checkmark.circle")
                        }
                    }
                    .onTapGesture {
                        if vm.selectedTag == tag {
                            vm.selectedTag = nil
                        } else {
                            vm.selectedTag = tag
                        }
                    }
                    
                }
            }
        }
        .listStyle(.sidebar)
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView()
    }
}
