//
//  SymblConversationData.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

import Foundation

// MARK: - SymblData
public struct SymblConversationData: Codable {
    public var conversationID: String?

    enum CodingKeys: String, CodingKey {
        case conversationID
    }

    public init(conversationID: String) {
        self.conversationID = conversationID
    }
}

// MARK: SymblData convenience initializers and mutators

public extension SymblConversationData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblConversationData.self, from: data)
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
        conversationID: String? = nil
    ) -> SymblConversationData {
        return SymblConversationData(
            conversationID: conversationID ?? self.conversationID!
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
