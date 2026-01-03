//
//  UnkeyedContainerEncodingStrategy.swift
//  URLQueryItemCoder
//
//  Created by Louis Prud'homme on 03/01/2026.
//

public enum UnkeyedContainerEncodingStrategy {
    case repeated
    case ordered

    /// The default strategy is `.ordered`.
    /// It should probably be `.repeated` but we're keeping backwards compatibility
    public static let `default` = Self.ordered
}
