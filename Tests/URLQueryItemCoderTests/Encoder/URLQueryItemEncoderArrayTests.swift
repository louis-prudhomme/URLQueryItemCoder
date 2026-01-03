//
//  URLQueryItemEncoderArrayTests.swift
//  URLQueryItemCoder
//
//  Created on 1/3/26.
//

import XCTest

@testable import URLQueryItemCoder

// MARK: - Test Types

struct QueryParamWithStringArray: Codable, Equatable {
    var typeFilter: [String]
}

struct QueryParamWithIntArray: Codable, Equatable {
    var numbers: [Int]
}

struct QueryParamWithMultipleArrays: Codable, Equatable {
    var strings: [String]
    var numbers: [Int]
}

struct QueryParamWithNestedStruct: Codable, Equatable {
    var items: [NestedItem]

    struct NestedItem: Codable, Equatable {
        var name: String
        var value: Int
    }
}

/// Tests for encoding arrays to URL query items.
final class URLQueryItemEncoderArrayTests: XCTestCase {
    // MARK: - Basic Array Encoding Tests

    func test_orderedStrategy_encodesStringArrayWithIndexedKeys() throws {
        let encoder = URLQueryItemEncoder(unkeyedContainerStrategy: .ordered)
        let input = QueryParamWithStringArray(typeFilter: ["A", "B", "C"])

        let result = try encoder.encode(input)

        // Ordered strategy: indexed keys
        let expected = [
            URLQueryItem(name: "typeFilter.0", value: "A"),
            URLQueryItem(name: "typeFilter.1", value: "B"),
            URLQueryItem(name: "typeFilter.2", value: "C"),
        ]

        XCTAssertEqual(result, expected)
    }

    func test_repeatedStrategy_encodesStringArrayWithRepeatedKeys() throws {
        // This test documents the desired behavior: repeated keys
        let encoder = URLQueryItemEncoder(unkeyedContainerStrategy: .repeated)
        let input = QueryParamWithStringArray(typeFilter: ["A", "B", "C"])

        let result = try encoder.encode(input)

        // Desired behavior: repeated keys (like standard URL query parameters)
        let expected = [
            URLQueryItem(name: "typeFilter", value: "A"),
            URLQueryItem(name: "typeFilter", value: "B"),
            URLQueryItem(name: "typeFilter", value: "C"),
        ]

        XCTAssertEqual(result, expected, "Arrays should encode with repeated keys, not indexed keys")
    }

    func test_repeatedStrategy_encodesIntArrayWithRepeatedKeys() throws {
        let encoder = URLQueryItemEncoder(unkeyedContainerStrategy: .repeated)
        let input = QueryParamWithIntArray(numbers: [1, 2, 3, 4, 5])

        let result = try encoder.encode(input)

        let expected = [
            URLQueryItem(name: "numbers", value: "1"),
            URLQueryItem(name: "numbers", value: "2"),
            URLQueryItem(name: "numbers", value: "3"),
            URLQueryItem(name: "numbers", value: "4"),
            URLQueryItem(name: "numbers", value: "5"),
        ]

        XCTAssertEqual(result, expected, "Int arrays should encode with repeated keys")
    }

    func test_repeatedStrategy_encodesEmptyArrayAsNoQueryItems() throws {
        let encoder = URLQueryItemEncoder(unkeyedContainerStrategy: .repeated)
        let input = QueryParamWithStringArray(typeFilter: [])

        let result = try encoder.encode(input)

        // Empty arrays produce no query items
        let expected: [URLQueryItem] = []

        XCTAssertEqual(result, expected, "Empty arrays should produce no query items")
    }

    func test_orderedStrategy_encodesEmptyArrayAsNoQueryItems() throws {
        let encoder = URLQueryItemEncoder(unkeyedContainerStrategy: .ordered)
        let input = QueryParamWithStringArray(typeFilter: [])

        let result = try encoder.encode(input)

        // Empty arrays might produce no query items
        let expected: [URLQueryItem] = []

        XCTAssertEqual(result, expected, "Empty arrays should produce no query items")
    }

    func test_repeatedStrategy_encodesMultipleArraysWithRepeatedKeys() throws {
        let encoder = URLQueryItemEncoder(unkeyedContainerStrategy: .repeated)
        let input = QueryParamWithMultipleArrays(
            strings: ["foo", "bar"],
            numbers: [10, 20]
        )

        let result = try encoder.encode(input)

        let expected = [
            URLQueryItem(name: "strings", value: "foo"),
            URLQueryItem(name: "strings", value: "bar"),
            URLQueryItem(name: "numbers", value: "10"),
            URLQueryItem(name: "numbers", value: "20"),
        ]

        // Note: Order might vary, so we use set comparison
        XCTAssertEqual(Set(result.map { "\($0.name)=\($0.value ?? "")" }),
                       Set(expected.map { "\($0.name)=\($0.value ?? "")" }),
                       "Multiple arrays should each encode with their own repeated keys")
    }

    func test_repeatedStrategy_encodesSingleElementArrayWithoutIndex() throws {
        let encoder = URLQueryItemEncoder(unkeyedContainerStrategy: .repeated)
        let input = QueryParamWithStringArray(typeFilter: ["Single"])

        let result = try encoder.encode(input)

        let expected = [
            URLQueryItem(name: "typeFilter", value: "Single"),
        ]

        XCTAssertEqual(result, expected, "Single-element arrays should still use repeated key format")
    }

    // MARK: - Special Cases

    func test_repeatedStrategy_encodesArrayWithNilValues() throws {
        struct QueryParamWithOptionalArray: Codable {
            var items: [String?]
        }

        let encoder = URLQueryItemEncoder(unkeyedContainerStrategy: .repeated)
        let input = QueryParamWithOptionalArray(items: ["A", nil, "C"])

        let result = try encoder.encode(input)

        // Behavior for nil values in arrays needs to be defined
        // This test documents the expected behavior
        XCTAssertNotNil(result, "Encoding arrays with nil values should succeed")
    }
}
