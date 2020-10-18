//
//  FeedViewModel.swift
//  EssentialFeed
//
//  Created by Sami Ali on 10/18/20.
//

public struct FeedViewModel {
    public let feed: [FeedImage]
}

public protocol FeedView {
    func display(_ viewModel: FeedViewModel)
}
