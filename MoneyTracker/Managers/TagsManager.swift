//
//  CustomTagsManager.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 16.07.2022.
//

import CoreData

/// Manager for tags
struct TagsManager {
    private var viewContext = PersistenceController.shared.container.viewContext
    
    /// Add new custom tag
    func addTag(name: String, emoji: String) -> Tag {
        let tag = Tag(context: viewContext)
        tag.name = name
        tag.emoji = emoji
        tag.date = Date()
        
        try! viewContext.save()
        return tag
    }
    
    /// Remove tag by in index
    func removeTag(index: Int) {
        viewContext.delete(getTags()[index])
        try! viewContext.save()
    }
    
    /// Remove tag by tag
    func removeTag(tag: Tag) {
        viewContext.delete(tag)
        try! viewContext.save()
    }
    
    /// Get all tags
    func getTags() -> [Tag] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tag")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Tag.date, ascending: true)]
        let array =  try! viewContext.fetch(request) as! Array<Tag>
        return array
    }
    
    /// Get default tag
    func getDefaultTag() -> Tag {
        return getTags()[0]
    }
}
