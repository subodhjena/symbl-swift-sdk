//
//  File.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let symblInsightData = try SymblInsightData(json)

import Foundation

// MARK: - SymblInsightData
public struct SymblInsightResponse: Codable {
    public var type: String
    public var insights: [SymblInsight]
    public var sequenceNumber: Int

    public init(type: String, insights: [SymblInsight], sequenceNumber: Int) {
        self.type = type
        self.insights = insights
        self.sequenceNumber = sequenceNumber
    }
}

// MARK: SymblInsightData convenience initializers and mutators

public extension SymblInsightResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblInsightResponse.self, from: data)
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
        type: String? = nil,
        insights: [SymblInsight]? = nil,
        sequenceNumber: Int? = nil
    ) -> SymblInsightResponse {
        return SymblInsightResponse(
            type: type ?? self.type,
            insights: insights ?? self.insights,
            sequenceNumber: sequenceNumber ?? self.sequenceNumber
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SymblInsight
public struct SymblInsight: Codable {
    public var id: String
    public var confidence: Double
    public var hints: [SymblHint]
    public var type: String
    public var assignee: SymblAssignee
    public var tags: [JSONAny]
    public var dismissed: Bool
    public var payload: SymblPayload
    public var from: SymblAssignee
    public var entities: JSONNull?
    public var messageReference: SymblMessageReference

    public init(id: String, confidence: Double, hints: [SymblHint], type: String, assignee: SymblAssignee, tags: [JSONAny], dismissed: Bool, payload: SymblPayload, from: SymblAssignee, entities: JSONNull?, messageReference: SymblMessageReference) {
        self.id = id
        self.confidence = confidence
        self.hints = hints
        self.type = type
        self.assignee = assignee
        self.tags = tags
        self.dismissed = dismissed
        self.payload = payload
        self.from = from
        self.entities = entities
        self.messageReference = messageReference
    }
}

// MARK: SymblInsight convenience initializers and mutators

public extension SymblInsight {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblInsight.self, from: data)
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
        id: String? = nil,
        confidence: Double? = nil,
        hints: [SymblHint]? = nil,
        type: String? = nil,
        assignee: SymblAssignee? = nil,
        tags: [JSONAny]? = nil,
        dismissed: Bool? = nil,
        payload: SymblPayload? = nil,
        from: SymblAssignee? = nil,
        entities: JSONNull?? = nil,
        messageReference: SymblMessageReference? = nil
    ) -> SymblInsight {
        return SymblInsight(
            id: id ?? self.id,
            confidence: confidence ?? self.confidence,
            hints: hints ?? self.hints,
            type: type ?? self.type,
            assignee: assignee ?? self.assignee,
            tags: tags ?? self.tags,
            dismissed: dismissed ?? self.dismissed,
            payload: payload ?? self.payload,
            from: from ?? self.from,
            entities: entities ?? self.entities,
            messageReference: messageReference ?? self.messageReference
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SymblAssignee
public struct SymblAssignee: Codable {
    public var id, name, userID: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case userID
    }

    public init(id: String, name: String, userID: String) {
        self.id = id
        self.name = name
        self.userID = userID
    }
}

// MARK: SymblAssignee convenience initializers and mutators

public extension SymblAssignee {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblAssignee.self, from: data)
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
        id: String? = nil,
        name: String? = nil,
        userID: String? = nil
    ) -> SymblAssignee {
        return SymblAssignee(
            id: id ?? self.id,
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

// MARK: - SymblHint
public struct SymblHint: Codable {
    public var key, value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

// MARK: SymblHint convenience initializers and mutators

public extension SymblHint {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblHint.self, from: data)
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
        key: String? = nil,
        value: String? = nil
    ) -> SymblHint {
        return SymblHint(
            key: key ?? self.key,
            value: value ?? self.value
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
