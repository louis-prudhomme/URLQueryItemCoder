//
//  URLQueryItemEncoder.swift
//  URLQueryItemCoder
//
//  Created by Kyle Hughes on 1/15/23.
//

import Combine
import Foundation

/// An object that encodes instances of a data type as `URLQueryItem` name-value pairs.
public struct URLQueryItemEncoder {
    /// The strategies used by this encoder for encoding `Encodable` values.
    public var strategies: EncodingStrategies

    /// The formatting settings used on the output of the encoder.
    public var outputFormatting: OutputFormatting

    // MARK: Public Initialization

    /// Creates a new, reusable `URLQueryItem` encoder.
    ///
    /// The default formatting settings and encoding strategies are used if none are supplied.
    ///
    /// - Parameter dataStrategy: The strategy to use for encoding `Data` values.
    /// - Parameter dateStrategy: The strategy to use for encoding `Date` values.
    /// - Parameter keyStrategy: The strategy to use for encoding keys on keyed containers.
    /// - Parameter nonConformingFloatStrategy: The strategy to use for encoding non-`URLQueryItem`-conforming
    ///   floating-point values (IEEE 754 infinity and NaN).
    /// - Parameter outputFormatting: The formatting settings used on the output of the encoder.
    /// - Returns: A new, reusable `URLQueryItem` encoder.
    @inlinable
    public init(
        dataStrategy: DataEncodingStrategy = .default,
        dateStrategy: DateEncodingStrategy = .default,
        keyStrategy: KeyEncodingStrategy = .default,
        nonConformingFloatStrategy: NonConformingFloatEncodingStrategy = .default,
        unkeyedContainerStrategy: UnkeyedContainerEncodingStrategy = .default,
        outputFormatting: OutputFormatting = .default
    ) {
        self.init(
            strategies: EncodingStrategies(
                dataStrategy: dataStrategy,
                dateStrategy: dateStrategy,
                keyStrategy: keyStrategy,
                nonConformingFloatStrategy: nonConformingFloatStrategy,
                unkeyedContainerStrategy: unkeyedContainerStrategy
            ),
            outputFormatting: outputFormatting
        )
    }

    /// Creates a new, reusable `URLQueryItem` encoder.
    ///
    /// The default formatting settings and encoding strategies are used if none are supplied.
    ///
    /// - Parameter strategies: The strategies for this encoder to use. The default value is `.default`.
    /// - Parameter outputFormatting: The formatting settings used on the output of the encoder.
    /// - Returns: A new, reusable `URLQueryItem` encoder.
    public init(strategies: EncodingStrategies, outputFormatting: OutputFormatting = .default) {
        self.strategies = strategies
        self.outputFormatting = outputFormatting
    }

    // MARK: Private Instance Interface

    private func encode(
        _ container: EncodingContainer?,
        at key: String = String(),
        into kvRepresentation: inout [(name: String, value: String?)]
    ) {
        guard let container else {
            return
        }

        let separator = key.isEmpty ? "" : "."

        switch container {
        case let .keyed(keyedContainer):
            if keyedContainer.children.isEmpty {
                if !key.isEmpty {
                    kvRepresentation.append((name: key, value: String()))
                }
            } else {
                for (subKey, childContainer) in keyedContainer.children {
                    let nextKey = "\(key)\(separator)\(subKey)"
                    encode(childContainer, at: nextKey, into: &kvRepresentation)
                }
            }
        case let .lowLevelEncoder(lowLevelEncoder):
            guard let childContainer = lowLevelEncoder.container else {
                preconditionFailure("Nothing was never encoded to nested low level encoder.")
            }
            encode(childContainer, at: key, into: &kvRepresentation)
        case let .singleValue(singleValueContainer):
            switch singleValueContainer.storage {
            case let .container(childContainer):
                encode(childContainer, at: key, into: &kvRepresentation)
            case let .primitive(value):
                if let value {
                    kvRepresentation.append((name: key, value: String(describing: value)))
                } else if !key.isEmpty {
                    kvRepresentation.append((name: key, value: nil))
                }
            case .none:
                preconditionFailure("Value was never encoded to single value container.")
            }
        case let .unkeyed(unkeyedContainer):
            for index in unkeyedContainer.children.indices {
                let childContainer = unkeyedContainer.children[index]
                let nextKey = switch strategies.unkeyedContainerStrategy {
                case .ordered: "\(key)\(separator)\(index)"
                case .repeated: key.isEmpty ? "\(index)" : key
                }

                encode(childContainer, at: nextKey, into: &kvRepresentation)
            }
        }
    }
}

// MARK: - TopLevelEncoder Extension

extension URLQueryItemEncoder: TopLevelEncoder {
    // MARK: Public Instance Interface

    /// Encodes an instance of the indicated type.
    ///
    /// - Parameter value: The instance to encode.
    /// - Returns: The query items that represent the given value.
    public func encode(_ value: some Encodable) throws -> [URLQueryItem] {
        let container = try EncodingContainer.encodeWithSpecialTreatment(value, at: [], using: strategies)

        var kvRepresentation: [(name: String, value: String?)] = []

        encode(container, into: &kvRepresentation)

        let result = kvRepresentation.map { URLQueryItem(name: $0.name, value: $0.value) }

        if outputFormatting.contains(.sortedKeys) {
            return result.sorted { $0.name < $1.name }
        } else {
            return result
        }
    }
}
