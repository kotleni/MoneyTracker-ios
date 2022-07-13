//
//  SearchBarView.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 13.07.2022.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var hint: String
 
    @State private var isEditing = false
 
    var body: some View {
        HStack {
            TextField(hint, text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
                .onTapGesture {
                    self.isEditing = true
                }
 
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
 
                }) {
                    Text("btn_cancel".localized)
                }
                .padding(.trailing, 18)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}


struct SearchBarPreviews: PreviewProvider {
    static var previews: some View {
        SearchBarView(text: .constant(""), hint: "Enter currency name")
    }
}
