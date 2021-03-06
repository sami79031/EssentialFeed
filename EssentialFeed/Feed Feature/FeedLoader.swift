//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Sami Ali on 9/30/20.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
