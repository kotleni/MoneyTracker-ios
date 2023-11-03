//
//  JsonDocument.swift
//  MoneyTracker
//
//  Created by Viktor Varenik on 19.08.2022.
//

import SwiftUI
import UniformTypeIdentifiers

/// Json data document
struct JsonDocument: FileDocument {
    static var readableContentTypes: [UTType] = [.text]
    private var text: String
    
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            text = String(decoding: data, as: UTF8.self)
        } else {
            text = "[]"
        }
    }
    
    init(text: String) {
        self.text = text
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = Data(text.utf8)
        return FileWrapper(regularFileWithContents: data)
    }
}
