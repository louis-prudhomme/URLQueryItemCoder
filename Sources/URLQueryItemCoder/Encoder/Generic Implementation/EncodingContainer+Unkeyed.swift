//
//  EncodingContainer+Unkeyed.swift
//  URLQueryItemCoder
//
//  Created by Kyle Hughes on 1/15/23.
//

extension EncodingContainer {
    final class Unkeyed {
        private(set) var children: [EncodingContainer]
        private(set) var codingPath: [any CodingKey]
        private(set) var count: Int
        private(set) var currentIndex: Int

        private let configuration: EncodingStrategies

        // MARK: Internal Initialization

        init(codingPath: [any CodingKey], configuration: EncodingStrategies) {
            self.codingPath = codingPath
            self.configuration = configuration

            count = 0
            children = []
            currentIndex = children.startIndex
        }

        // MARK: Private Instance Interface

        private func nextCodingPath(appending key: IntCodingKey) -> [any CodingKey] {
            var nextCodingPath = codingPath
            nextCodingPath.append(key)

            return nextCodingPath
        }

        private func nextDecodingKey() -> IntCodingKey {
            defer {
                currentIndex += 1
            }

            return IntCodingKey(intValue: currentIndex)
        }

        private func nextEncodingKey() -> IntCodingKey {
            defer {
                count += 1
            }

            return IntCodingKey(intValue: count)
        }
    }
}

// MARK: - UnkeyedEncodingContainer Extension

extension EncodingContainer.Unkeyed: UnkeyedEncodingContainer {
    // MARK: Internal Instance Interface

    func encode(_ value: Bool) throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encode(value)

        children.append(.singleValue(singleValueContainer))
    }

    func encode(_ value: String) throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encode(value)

        children.append(.singleValue(singleValueContainer))
    }

    func encode(_ value: Double) throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encode(value)

        children.append(.singleValue(singleValueContainer))
    }

    func encode(_ value: Float) throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encode(value)

        children.append(.singleValue(singleValueContainer))
    }

    func encode(_ value: Int) throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encode(value)

        children.append(.singleValue(singleValueContainer))
    }

    func encode(_ value: Int8) throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encode(value)

        children.append(.singleValue(singleValueContainer))
    }

    func encode(_ value: Int16) throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encode(value)

        children.append(.singleValue(singleValueContainer))
    }

    func encode(_ value: Int32) throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encode(value)

        children.append(.singleValue(singleValueContainer))
    }

    func encode(_ value: Int64) throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encode(value)

        children.append(.singleValue(singleValueContainer))
    }

    func encode(_ value: UInt) throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encode(value)

        children.append(.singleValue(singleValueContainer))
    }

    func encode(_ value: UInt8) throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encode(value)

        children.append(.singleValue(singleValueContainer))
    }

    func encode(_ value: UInt16) throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encode(value)

        children.append(.singleValue(singleValueContainer))
    }

    func encode(_ value: UInt32) throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encode(value)

        children.append(.singleValue(singleValueContainer))
    }

    func encode(_ value: UInt64) throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encode(value)

        children.append(.singleValue(singleValueContainer))
    }

    func encode<Value>(_ value: Value) throws where Value: Encodable {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        try children.append(.encodeWithSpecialTreatment(value, at: nextCodingPath, using: configuration))
    }

    func encodeNil() throws {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let singleValueContainer = EncodingContainer.SingleValue(
            codingPath: nextCodingPath,
            configuration: configuration
        )

        try singleValueContainer.encodeNil()

        children.append(.singleValue(singleValueContainer))
    }

    func nestedContainer<NestedKey>(
        keyedBy _: NestedKey.Type
    ) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let keyedContainer = EncodingContainer.Keyed(codingPath: nextCodingPath, configuration: configuration)

        children.append(.keyed(keyedContainer))

        return KeyedEncodingContainer(keyedContainer.wrapped())
    }

    func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let unkeyedContainer = EncodingContainer.Unkeyed(codingPath: nextCodingPath, configuration: configuration)

        children.append(.unkeyed(unkeyedContainer))

        return unkeyedContainer
    }

    func superEncoder() -> Encoder {
        let nextCodingKey = nextEncodingKey()
        let nextCodingPath = nextCodingPath(appending: nextCodingKey)

        let lowLevelEncoder = LowLevelEncoder(codingPath: nextCodingPath, configuration: configuration)

        children.append(.lowLevelEncoder(lowLevelEncoder))

        return lowLevelEncoder
    }
}
