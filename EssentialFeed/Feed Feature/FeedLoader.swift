//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Sami Ali on 9/30/20.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
