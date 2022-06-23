//
//  SymblUser.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

import Foundation

// MARK: - SymblUser
public struct SymblUser: Codable {
    public var name, userID, id: String

    enum CodingKeys: String, CodingKey {
        case name
        case userID
        case id
    }

    public init(name: String, userID: String, id: String) {
        self.name = name
        self.userID = userID
        self.id = id
    }
}

// MARK: SymblUser convenience initializers and mutators

public extension SymblUser {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblUser.self, from: data)
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
        userID: String? = nil,
        id: String? = nil
    ) -> SymblUser {
        return SymblUser(
            name: name ?? self.name,
            userID: userID ?? self.userID,
            id: id ?? self.id
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
