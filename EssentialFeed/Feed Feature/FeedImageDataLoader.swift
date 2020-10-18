//
//  FeedImageDataLoader.swift
//  EssentialFeediOS
//
//  Created by Sami Ali on 10/12/20.
//

import Foundation

public protocol FeedImageDataLoaderTask {
    func cancel()
}

public protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) ->  FeedImageDataLoaderTask
}
