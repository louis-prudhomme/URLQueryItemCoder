//
//  DecodingContainer+SingleValue.swift
//  URLQueryItemCoder
//
//  Created by Kyle Hughes on 2/21/23.
//

import Foundation

extension DecodingContainer {
    /// A decoding container that holds a single primitive value.
    ///
    /// **As Keyed Value Container…**
    ///
    /// Only used for leaf node keyed containers that have no children (e.g. all nil properties). We can't detect that
    /// they are actually keyed containers when building our decoding representation because we don't have type
    /// information. The internal decoder system will know to ask for an keyed container and we will return this.
    ///
    /// **As Unkeyed Value Container…**
    ///
    /// Only used for leaf node unkeyed containers that have no children. We can't detect that they are actually unkeyed
    /// containers when building our decoding representation because we don't have type information. The internal
    /// decoder system will know to ask for an unkeyed container and we will return this.
    final class SingleValue {
        let codingPath: [any CodingKey]
        let configuration: DecodingStrategies

        private(set) var value: PrimitiveValue?

        // MARK: Internal Initialization

        init(codingPath: [any CodingKey], configuration: DecodingStrategies) {
            self.codingPath = codingPath
            self.configuration = configuration

            value = nil
        }

        // MARK: Internal Instance Interface

        func store(_ value: PrimitiveValue?) {
            precondition(
                self.value == nil,
                "A value was already stored in the single value container."
            )

            self.value = value
        }

        // MARK: Private Instance Interface

        private func nextCodingPath(appending key: any CodingKey) -> [any CodingKey] {
            var nextCodingPath = codingPath
            nextCodingPath.append(key)

            return nextCodingPath
        }

        private func unwrapPrimitiveValue<Target>(for target: Target.Type) throws -> PrimitiveValue {
            guard let value else {
                throw DecodingError.valueNotFound(target, .foundNilInsteadOfPrimitiveValue(at: codingPath))
            }

            return value
        }
    }
}

// MARK: - SingleValueDecodingContainer Extension

extension DecodingContainer.SingleValue: SingleValueDecodingContainer {
    // MARK: Internal Instance Interface

    func decode(_ type: Bool.Type) throws -> Bool {
        let primitiveValue = try unwrapPrimitiveValue(for: type)

        guard let decodedValue = primitiveValue.decode(type) else {
            throw DecodingError.typeMismatch(type, .primitiveValueMismatch(at: codingPath, for: type))
        }

        return decodedValue
    }

    func decode(_ type: String.Type) throws -> String {
        let primitiveValue = try unwrapPrimitiveValue(for: type)

        guard let decodedValue = primitiveValue.decode(type) else {
            throw DecodingError.typeMismatch(type, .primitiveValueMismatch(at: codingPath, for: type))
        }

        return decodedValue
    }

    func decode(_: Double.Type) throws -> Double {
        let lowLevelDecoder = LowLevelDecoder(container: .singleValue(self))

        return try configuration.nonConformingFloatStrategy.decode(insideOf: lowLevelDecoder)
    }

    func decode(_: Float.Type) throws -> Float {
        let lowLevelDecoder = LowLevelDecoder(container: .singleValue(self))

        return try configuration.nonConformingFloatStrategy.decode(insideOf: lowLevelDecoder)
    }

    func decode(_ type: Int.Type) throws -> Int {
        let primitiveValue = try unwrapPrimitiveValue(for: type)

        guard let decodedValue = primitiveValue.decode(type) else {
            throw DecodingError.typeMismatch(type, .primitiveValueMismatch(at: codingPath, for: type))
        }

        return decodedValue
    }

    func decode(_ type: Int8.Type) throws -> Int8 {
        let primitiveValue = try unwrapPrimitiveValue(for: type)

        guard let decodedValue = primitiveValue.decode(type) else {
            throw DecodingError.typeMismatch(type, .primitiveValueMismatch(at: codingPath, for: type))
        }

        return decodedValue
    }

    func decode(_ type: Int16.Type) throws -> Int16 {
        let primitiveValue = try unwrapPrimitiveValue(for: type)

        guard let decodedValue = primitiveValue.decode(type) else {
            throw DecodingError.typeMismatch(type, .primitiveValueMismatch(at: codingPath, for: type))
        }

        return decodedValue
    }

    func decode(_ type: Int32.Type) throws -> Int32 {
        let primitiveValue = try unwrapPrimitiveValue(for: type)

        guard let decodedValue = primitiveValue.decode(type) else {
            throw DecodingError.typeMismatch(type, .primitiveValueMismatch(at: codingPath, for: type))
        }

        return decodedValue
    }

    func decode(_ type: Int64.Type) throws -> Int64 {
        let primitiveValue = try unwrapPrimitiveValue(for: type)

        guard let decodedValue = primitiveValue.decode(type) else {
            throw DecodingError.typeMismatch(type, .primitiveValueMismatch(at: codingPath, for: type))
        }

        return decodedValue
    }

    func decode(_ type: UInt.Type) throws -> UInt {
        let primitiveValue = try unwrapPrimitiveValue(for: type)

        guard let decodedValue = primitiveValue.decode(type) else {
            throw DecodingError.typeMismatch(type, .primitiveValueMismatch(at: codingPath, for: type))
        }

        return decodedValue
    }

    func decode(_ type: UInt8.Type) throws -> UInt8 {
        let primitiveValue = try unwrapPrimitiveValue(for: type)

        guard let decodedValue = primitiveValue.decode(type) else {
            throw DecodingError.typeMismatch(type, .primitiveValueMismatch(at: codingPath, for: type))
        }

        return decodedValue
    }

    func decode(_ type: UInt16.Type) throws -> UInt16 {
        let primitiveValue = try unwrapPrimitiveValue(for: type)

        guard let decodedValue = primitiveValue.decode(type) else {
            throw DecodingError.typeMismatch(type, .primitiveValueMismatch(at: codingPath, for: type))
        }

        return decodedValue
    }

    func decode(_ type: UInt32.Type) throws -> UInt32 {
        let primitiveValue = try unwrapPrimitiveValue(for: type)

        guard let decodedValue = primitiveValue.decode(type) else {
            throw DecodingError.typeMismatch(type, .primitiveValueMismatch(at: codingPath, for: type))
        }

        return decodedValue
    }

    func decode(_ type: UInt64.Type) throws -> UInt64 {
        let primitiveValue = try unwrapPrimitiveValue(for: type)

        guard let decodedValue = primitiveValue.decode(type) else {
            throw DecodingError.typeMismatch(type, .primitiveValueMismatch(at: codingPath, for: type))
        }

        return decodedValue
    }

    func decode<Target>(_ type: Target.Type) throws -> Target where Target: Decodable {
        let lowLevelDecoder = LowLevelDecoder(container: .singleValue(self))

        return try lowLevelDecoder.decodeWithSpecialTreatment(as: type)
    }

    func decodeNil() -> Bool {
        value == nil
    }
}

// MARK: - KeyedDecodingContainerProtocol Extension

extension DecodingContainer.SingleValue: KeyedDecodingContainerProtocol {
    // MARK: Internal Instance Interface

    var allKeys: [StringCodingKey] {
        []
    }

    func contains(_: StringCodingKey) -> Bool {
        false
    }

    func decode(_: Bool.Type, forKey _: StringCodingKey) throws -> Bool {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decode(_: String.Type, forKey _: StringCodingKey) throws -> String {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decode(_: Double.Type, forKey _: StringCodingKey) throws -> Double {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decode(_: Float.Type, forKey _: StringCodingKey) throws -> Float {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decode(_: Int.Type, forKey _: StringCodingKey) throws -> Int {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decode(_: Int8.Type, forKey _: StringCodingKey) throws -> Int8 {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decode(_: Int16.Type, forKey _: StringCodingKey) throws -> Int16 {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decode(_: Int32.Type, forKey _: StringCodingKey) throws -> Int32 {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decode(_: Int64.Type, forKey _: StringCodingKey) throws -> Int64 {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decode(_: UInt.Type, forKey _: StringCodingKey) throws -> UInt {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decode(_: UInt8.Type, forKey _: StringCodingKey) throws -> UInt8 {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decode(_: UInt16.Type, forKey _: StringCodingKey) throws -> UInt16 {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decode(_: UInt32.Type, forKey _: StringCodingKey) throws -> UInt32 {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decode(_: UInt64.Type, forKey _: StringCodingKey) throws -> UInt64 {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decode<T>(_: T.Type, forKey _: StringCodingKey) throws -> T where T: Decodable {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func decodeNil(forKey _: StringCodingKey) throws -> Bool {
        true
    }

    func nestedContainer<NestedKey>(
        keyedBy _: NestedKey.Type,
        forKey _: StringCodingKey
    ) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func nestedUnkeyedContainer(forKey _: StringCodingKey) throws -> UnkeyedDecodingContainer {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func superDecoder() throws -> Decoder {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func superDecoder(forKey _: StringCodingKey) throws -> Decoder {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }
}

// MARK: - UnkeyedDecodingContainer Extension

extension DecodingContainer.SingleValue: UnkeyedDecodingContainer {
    // MARK: Internal Instance Interface

    var count: Int? {
        value == nil ? 0 : 1
    }

    var isAtEnd: Bool {
        true
    }

    var currentIndex: Int {
        0
    }

    func nestedContainer<NestedKey>(
        keyedBy _: NestedKey.Type
    ) throws -> KeyedDecodingContainer<NestedKey> where NestedKey: CodingKey {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }

    func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        throw DecodingError.dataCorrupted(.singleValueContainerCanOnlyActAsEmptyKeyedContainer(at: codingPath))
    }
}
