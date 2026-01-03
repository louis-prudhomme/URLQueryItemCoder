//
//  UnkeyedContainerEncodingStrategy.swift
//  URLQueryItemCoder
//
//  Created by Louis Prud'homme on 03/01/2026.
//

/// The strategy to use for encoding unkeyed containers.
public enum UnkeyedContainerEncodingStrategy {
    /// Encode all elements with the same key (compliant with the WHATWG URL Standard).
    case repeated
    /// Encode elements with indexed keys.
    case ordered

    /// The default strategy is `.ordered`.
    /// It should probably be `.repeated` but we're keeping backwards compatibility
    public static let `default` = Self.ordered
}
