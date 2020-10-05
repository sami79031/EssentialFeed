//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Sami Ali on 10/5/20.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
