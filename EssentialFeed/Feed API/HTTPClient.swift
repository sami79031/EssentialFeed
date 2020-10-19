//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Sami Ali on 10/1/20.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    @discardableResult
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) -> HTTPClientTask
}
