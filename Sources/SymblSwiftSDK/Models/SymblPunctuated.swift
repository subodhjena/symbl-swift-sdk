//
//  SymblPunctuated.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

import Foundation

// MARK: - SymblPunctuated
public struct SymblPunctuated: Codable {
    public var transcript: String

    public init(transcript: String) {
        self.transcript = transcript
    }
}

// MARK: SymblPunctuated convenience initializers and mutators

public extension SymblPunctuated {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblPunctuated.self, from: data)
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
        transcript: String? = nil
    ) -> SymblPunctuated {
        return SymblPunctuated(
            transcript: transcript ?? self.transcript
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
