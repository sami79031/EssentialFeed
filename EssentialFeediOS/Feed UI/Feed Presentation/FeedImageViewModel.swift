//
//  FeedImageViewModel.swift
//  EssentialFeediOS
//
//  Created by Sami Ali on 10/13/20.
//

import Foundation

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}
