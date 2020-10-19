//
//  HTTPURLResponse+StatusCode.swift
//  EssentialFeed
//
//  Created by Sami Ali on 10/19/20.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
