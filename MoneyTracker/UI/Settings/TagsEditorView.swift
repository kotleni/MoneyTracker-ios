//
//  TagsEditorView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import SwiftUI

struct TagsEditorView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var isSheetShow: Bool = false
    @State private var isTagError: Bool = false
    
    var body: some View {
        List {
            Section {
                ForEach(Tag.getAll(), id: \.self) { tag in
                    Text(tag.emoji! + " " + tag.name!)
                }
                .onDelete { indexSet in
                    if viewModel.tags[indexSet.first!].name! != "tag_any".localized {
                        viewModel.removeTag(index: indexSet.first!)
                    } else {
                        HapticManager.shared.error()
                        isTagError = true
                    }
                }
            }
            
            NavigationLink(isActive: $isSheetShow) {
                AddTagView(viewModel: viewModel, isSheetShow: $isSheetShow)
            } label: {
                Label("btn_addtag".localized, systemImage: "plus")
            }
        }
        .navigationTitle("label_tagseditor".localized)
        .navigationBarTitleDisplayMode(.inline)
        .toast(message: "toast_tagremove".localized, isShowing: $isTagError, config: .init())
    }
}
