//
//  String.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 17.07.2022.
//

import Foundation
import SwiftUI

extension String {
    // emojies utils
    var isSingleEmoji: Bool { count == 1 && containsEmoji }
    var containsEmoji: Bool { contains { $0.isEmoji } }
    var containsOnlyEmoji: Bool { !isEmpty && !contains { !$0.isEmoji } }
    var emojiString: String { emojis.map { String($0) }.reduce("", +) }
    var emojis: [Character] { filter { $0.isEmoji } }
    var emojiScalars: [UnicodeScalar] { filter { $0.isEmoji }.flatMap { $0.unicodeScalars } }
    
    func trim() -> String {
        return self
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\t", with: "")
    }
    
    func openAsLink() {
        guard let url = URL(string: self) else { return }
        UIApplication.shared.open(url)
    }
}
