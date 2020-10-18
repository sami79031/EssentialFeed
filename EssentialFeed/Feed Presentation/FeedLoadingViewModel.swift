//
//  FeedLoadingViewModel.swift
//  EssentialFeed
//
//  Created by Sami Ali on 10/18/20.
//

public struct FeedLoadingViewModel {
    public let isLoading: Bool
}

public protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}
