//
//  URLQueryItem+Optional.swift
//  URLQueryItemCoder
//
//  Created by Kyle Hughes on 12/30/22.
//

import Foundation

@testable import URLQueryItemCoder

public extension URLQueryItem {
    // MARK: Public Static Interface

    static func nilIfValueIsNil(name: String, value: String?) -> URLQueryItem? {
        guard let value else {
            return nil
        }

        return URLQueryItem(name: name, value: value)
    }

    static func nilIfValueIsNil(name: String, value: (some LosslessStringConvertible)?) -> URLQueryItem? {
        guard let value else {
            return nil
        }

        return URLQueryItem(name: name, value: value)
    }
}
