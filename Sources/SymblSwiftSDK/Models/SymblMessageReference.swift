//
//  File.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

import Foundation

// MARK: - SymblMessageReference
public struct SymblMessageReference: Codable {
    public var id, relation: String?

    public init(id: String?, relation: String?) {
        self.id = id
        self.relation = relation
    }
}

// MARK: SymblMessageReference convenience initializers and mutators

public extension SymblMessageReference {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblMessageReference.self, from: data)
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
        id: String?? = nil,
        relation: String?? = nil
    ) -> SymblMessageReference {
        return SymblMessageReference(
            id: id ?? self.id,
            relation: relation ?? self.relation
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
