//
//  File.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

import Foundation

// MARK: - SymblSpeaker
public struct SymblSpeaker: Codable {
    public var name, userID: String

    enum CodingKeys: String, CodingKey {
        case name
        case userID
    }

    public init(name: String, userID: String) {
        self.name = name
        self.userID = userID
    }
}

// MARK: SymblSpeaker convenience initializers and mutators

public extension SymblSpeaker {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblSpeaker.self, from: data)
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
        name: String? = nil,
        userID: String? = nil
    ) -> SymblSpeaker {
        return SymblSpeaker(
            name: name ?? self.name,
            userID: userID ?? self.userID
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
