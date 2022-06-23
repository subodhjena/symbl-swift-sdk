//
//  SymblRaw.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

import Foundation

// MARK: - SymblRaw
public struct SymblRaw: Codable {
    public var alternatives: [SymblAlternative]

    public init(alternatives: [SymblAlternative]) {
        self.alternatives = alternatives
    }
}

// MARK: SymblRaw convenience initializers and mutators

public extension SymblRaw {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblRaw.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        alternatives: [SymblAlternative]? = nil
    ) -> SymblRaw {
        return SymblRaw(
            alternatives: alternatives ?? self.alternatives
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
