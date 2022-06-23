//
//  SymblAlternative.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

import Foundation

// MARK: - SymblAlternative
public struct SymblAlternative: Codable {
    public var words: [JSONAny]
    public var transcript: String
    public var confidence: Int

    public init(words: [JSONAny], transcript: String, confidence: Int) {
        self.words = words
        self.transcript = transcript
        self.confidence = confidence
    }
}

// MARK: SymblAlternative convenience initializers and mutators

public extension SymblAlternative {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblAlternative.self, from: data)
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
        words: [JSONAny]? = nil,
        transcript: String? = nil,
        confidence: Int? = nil
    ) -> SymblAlternative {
        return SymblAlternative(
            words: words ?? self.words,
            transcript: transcript ?? self.transcript,
            confidence: confidence ?? self.confidence
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
