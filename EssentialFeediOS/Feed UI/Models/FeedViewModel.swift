//
//  FeedViewModel.swift
//  EssentialFeediOS
//
//  Created by Sami Ali on 10/13/20.
//

import EssentialFeed

final class FeedViewModel {
    typealias Observer<T> = (T) -> Void
    private let feedLoader: FeedLoader

    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }

    var onFeedLoad: Observer<[FeedImage]>?
    var onLoadingStateChange: Observer<Bool>?

    func loadFeed() {
        onLoadingStateChange?(true)
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onFeedLoad?(feed)
            }
            self?.onLoadingStateChange?(false)
        }
    }
}
