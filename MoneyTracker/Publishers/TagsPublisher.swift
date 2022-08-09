//
//  TagsPublisher.swift
//  MoneyTracker
//
//  Created by Victor Varenik on 27.07.2022.
//

import Combine

/// Publisher for loading tags
struct TagsPublisher: Publisher {
    typealias Output = [Tag]
    typealias Failure = Never
    
    let tagsManager: TagsManager
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, [Tag] == S.Input {
        let tags = tagsManager.getTags()
        let _ = subscriber.receive(tags)
    }
}
