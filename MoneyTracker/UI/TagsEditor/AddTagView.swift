//
//  AddTagView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import SwiftUI
import UIKit

struct AddTagView: View {
    @ObservedObject var viewModel: TagsEditorViewModel
    @Binding var isSheetShow: Bool
    
    @State private var emojiText: String = "🍕"
    @State private var nameText: String = ""
    @State private var isError: Bool = false
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Text("label_emoji".localized)
                    Spacer()
                    Picker(selection: $emojiText) {
                        ForEach(["🍕","🌈","👚","🎭","💻","📦","🐶","⚽️","🎮","💊","📚"], id: \.self) { emoji in
                            Text(emoji)
                        }
                    } label: {
                        Text("Emoji")
                    }
                    .pickerStyle(.menu)
                }
                
                HStack {
                    Text("label_tagname".localized)
                    Spacer()
                    TextField("hint_necessarily".localized, text: $nameText)
                        .multilineTextAlignment(.trailing)
                        .frame(width: UIScreen.main.bounds.width / 3)
                }
            }
        }
        .navigationBarTitle("title_addtag".localized, displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if EmojiValidator.validate(str: emojiText) &&
                        TagNameValidator.validate(str: nameText) {
                        viewModel.addTag(name: nameText, emoji: emojiText)
                        isSheetShow = false
                    } else {
                        isError = true
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.error)
                    }
                } label: {
                    Text("btn_create".localized)
                }
            }
        }
        .toast(message: "toast_invalidtagdata".localized, isShowing: $isError, config: .init())
    }
}

struct AddTagPreview: PreviewProvider {
    static var previews: some View {
        AddTagView(viewModel: TagsEditorViewModel.init(paymentsManager: PaymentsManager(), storageManager: StorageManager(), notificationsManager: NotificationsManager(), tagsManager: TagsManager(), storeManager: StoreManager(keychain: KeychainManager(), productsIDs: .init()), keychainManager: KeychainManager()), isSheetShow: .constant(false))
    }
}
