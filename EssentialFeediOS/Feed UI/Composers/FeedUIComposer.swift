//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Sami Ali on 10/12/20.
//

import UIKit
import EssentialFeed

public final class FeedUIComposer {
    private init() {}
    
    public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let presentationAdapter = FeedLoaderPresentationAdapter(feedLoader: MainQueueDispatchDecorator(decoratee: feedLoader))
        let refreshController = FeedRefreshViewController(delegate: presentationAdapter)
        let feedController = FeedViewController.makeWith(title: FeedPresenter.title, refreshController: refreshController)
        
        presentationAdapter.presenter = FeedPresenter(
            feedView: FeedViewAdapter(controller: feedController, imageLoader: MainQueueDispatchDecorator(decoratee: imageLoader)),
            errorView: WeakRefVirtualProxy(feedController),
            loadingView: WeakRefVirtualProxy(refreshController))
        
        return feedController
    }
    
}

private extension FeedViewController {
    static func makeWith(title: String, refreshController: FeedRefreshViewController) -> FeedViewController {
        let feedController = FeedViewController(refreshController: refreshController)
        feedController.title = title
        
        return feedController
    }
}

