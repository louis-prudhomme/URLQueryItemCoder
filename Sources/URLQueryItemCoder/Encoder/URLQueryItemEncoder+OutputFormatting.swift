//
//  URLQueryItemEncoder+OutputFormatting.swift
//  URLQueryItemCoder
//
//  Created by Kyle Hughes on 4/11/23.
//

public extension URLQueryItemEncoder {
    /// The output formatting options that determine the element order of an encoded `URLQueryItem` array.
    struct OutputFormatting: OptionSet {
        /// A raw value representing a set of output formatting options.
        public let rawValue: Int

        // MARK: Public Initialization

        /// Creates a new set of output formatting options from the given raw value.
        ///
        /// - Parameter rawValue: A raw value representing a set of output formatting options.
        /// - Returns: A new set of output formatting options from the given raw value.
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}

// MARK: - Constants

public extension URLQueryItemEncoder.OutputFormatting {
    /// The default formatting options.
    ///
    /// Equals the empty set, `[]`.
    static let `default`: Self = []

    /// The output formatting option that sorts keys in lexicographic order.
    static let sortedKeys = Self(rawValue: 1 << 0)
}
