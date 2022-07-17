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
    @State private var isShowResetAlert: Bool = false
    @State private var isShowResetToast: Bool = false
    
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
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("btn_reset".localized) {
                    isShowResetAlert = true
                }
            }
        })
        .navigationTitle("label_tagseditor".localized)
        .navigationBarTitleDisplayMode(.inline)
        .toast(message: "toast_tagremove".localized, isShowing: $isTagError, config: .init())
        .toast(message: "toast_tagreset".localized, isShowing: $isShowResetToast, config: .init())
        .alert("label_resettags".localized, isPresented: $isShowResetAlert) {
            Button("btn_yes".localized) {
                isShowResetToast = true
                isShowResetAlert = false
                viewModel.resetTags()
            }
            
            Button("btn_no".localized) {
                isShowResetAlert = false
            }
        }
    }
}
