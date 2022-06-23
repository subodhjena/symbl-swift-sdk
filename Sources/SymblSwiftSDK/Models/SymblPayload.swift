//
//  SymblPayload.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

import Foundation

// MARK: - SymblPayload
public struct SymblPayload: Codable {
    public var raw: SymblRaw?
    public var content, contentType: String?

    public init(raw: SymblRaw, content: String, contentType: String) {
        self.content = content
        self.contentType = contentType
    }
}

// MARK: SymblPayload convenience initializers and mutators

public extension SymblPayload {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblPayload.self, from: data)
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
        raw: SymblRaw? = nil,
        content: String? = nil,
        contentType: String? = nil
    ) -> SymblPayload {
        return SymblPayload(
            raw: raw ?? self.raw!,
            content: content ?? self.content!,
            contentType: contentType ?? self.contentType!
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
