//
//  TagsEditorViewModel.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 25.07.2022.
//

import SwiftUI
import Combine

class TagsEditorViewModel: ObservableObject, BaseViewModel {
    var publishers: Set<AnyCancellable> = []
    private let tagsManager: TagsManager
    
    @Published var tags: [Tag] = []
    
    init(tagsManager: TagsManager) {
        self.tagsManager = tagsManager
    }
    
    /// Load data
    func loadData() {
        loadTags()
    }
    
    /// Load tags
    func loadTags() {
        DispatchQueue.global().async {
            let _tags = self.tagsManager.getTags()
            DispatchQueue.main.async {
                self.tags = _tags
                
                // first setup for tags
                // is tags not exist
                if self.tags.isEmpty {
                    self.addTag(name: "tag_food".localized, emoji: "🍗")
                    self.addTag(name: "tag_clothes".localized, emoji: "👚")
                    self.addTag(name: "tag_entertainment".localized, emoji: "🎭")
                    self.addTag(name: "tag_technique".localized, emoji: "💻")
                    self.addTag(name: "tag_any".localized, emoji: "📦")
                }
            }
        }
    }
    
    /// Add new tag
    func addTag(name: String, emoji: String) {
        let tag = tagsManager.addTag(name: name, emoji: emoji)
        tags.append(tag)
    }
    
    /// Remove tag by index
    func removeTag(index: Int) {
        tagsManager.removeTag(tag: tags[index])
        tags.remove(at: index)
    }
    
    /// Remove all tags and set default
    func resetTags() {
        tags.forEach { _ in
            removeTag(index: 0)
        }
        loadTags()
    }
}
