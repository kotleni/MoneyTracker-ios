//
//  AddTagView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import SwiftUI
import UIKit

struct AddTagView: View {
    @ObservedObject var viewModel: MainViewModel
    @Binding var isSheetShow: Bool
    
    @State private var emojiText: String = ""
    @State private var nameText: String = ""
    @State private var isError: Bool = false
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Text("label_emoji".localized)
                    Spacer()
                    EmojiTextField(text: $emojiText, placeholder: "hint_necessarily".localized)
                        .frame(width: UIScreen.main.bounds.width / 3)
                }
                
                HStack {
                    Text("label_name".localized)
                    Spacer()
                    TextField("hint_necessarily".localized, text: $nameText)
                        .multilineTextAlignment(.trailing)
                        .frame(width: UIScreen.main.bounds.width / 3)
                }
            }
        }
        .navigationBarTitle("btn_addtag".localized, displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if EmojiValidator.validate(str: emojiText) &&
                        TagNameValidator.validate(str: nameText) {
                        viewModel.addTag(name: nameText, emoji: emojiText)
                        isSheetShow = false
                    } else {
                        isError = true
                        HapticManager.shared.error()
                    }
                } label: {
                    Text("btn_create".localized)
                }
            }
        }
        .toast(message: "toast_invalid".localized, isShowing: $isError, config: .init())
    }
}
