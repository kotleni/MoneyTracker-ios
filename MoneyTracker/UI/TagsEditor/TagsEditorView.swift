//
//  TagsEditorView.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 16.07.2022.
//

import SwiftUI

struct TagsEditorView: View {
    @EnvironmentObject var router: SettingsCoordinator.Router
    
    @ObservedObject var viewModel: TagsEditorViewModel
    @State private var isSheetShow: Bool = false
    @State private var isTagError: Bool = false
    @State private var isShowResetAlert: Bool = false
    @State private var isShowResetToast: Bool = false
    
    var body: some View {
        List {
            Section {
                ForEach(viewModel.tags, id: \.self) { tag in
                    Text((tag.emoji ?? "") + " " + (tag.name ?? ""))
                }
                .onDelete { indexSet in
                    if let index = indexSet.first {
                        if viewModel.tags[index].name ?? "" != "tag_any".localized {
                            viewModel.removeTag(index: index)
                        } else {
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.error)
                            isTagError = true
                        }
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
        .navigationTitle("title_tagseditor".localized)
        .navigationBarTitleDisplayMode(.inline)
        .toast(message: "toast_tagremove".localized, isShowing: $isTagError, config: .init())
        .toast(message: "toast_tagreset".localized, isShowing: $isShowResetToast, config: .init())
        .alert(isPresented: $isShowResetAlert) {
            Alert(
                title: Text("label_resettags".localized),
                primaryButton: .destructive(Text("btn_yes".localized),
                action: {
                isShowResetToast = true
                isShowResetAlert = false
                viewModel.resetTags()
            }), secondaryButton: .cancel(Text("btn_no".localized), action: {
                isShowResetAlert = false
            }))
        }
        .onAppear { viewModel.loadData() }
    }
}

struct TagsEditorPreview: PreviewProvider {
    static var previews: some View {
        TagsEditorView(viewModel: TagsEditorViewModel.init(managersContainer: .getForPreview()))
    }
}
