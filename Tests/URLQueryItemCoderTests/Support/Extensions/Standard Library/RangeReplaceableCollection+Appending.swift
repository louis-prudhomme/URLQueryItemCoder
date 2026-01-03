//
//  RangeReplaceableCollection+Appending.swift
//  URLQueryItemCoder
//
//  Created by Kyle Hughes on 12/27/22.
//

public extension RangeReplaceableCollection {
    // MARK: Public Instance Interface

    func appending(_ element: Element) -> Self {
        var copy = self
        copy.append(element)

        return copy
    }
}
