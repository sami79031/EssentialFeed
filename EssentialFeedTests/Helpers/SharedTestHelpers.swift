//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Sami Ali on 10/6/20.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}
