//
//  File.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

import Foundation

// MARK: - SymblMessageResponse
public struct SymblMessageResponse: Codable {
    public var type: String
    public var messages: [SymblMessage]
    public var sequenceNumber: Int

    public init(type: String, messages: [SymblMessage], sequenceNumber: Int) {
        self.type = type
        self.messages = messages
        self.sequenceNumber = sequenceNumber
    }
}

// MARK: SymblMessageResponse convenience initializers and mutators

public extension SymblMessageResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblMessageResponse.self, from: data)
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
        messages: [SymblMessage]? = nil,
        sequenceNumber: Int? = nil
    ) -> SymblMessageResponse {
        return SymblMessageResponse(
            type: type ?? self.type,
            messages: messages ?? self.messages,
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

// MARK: - SymblChannel
public struct SymblChannel: Codable {
    public var id: String

    public init(id: String) {
        self.id = id
    }
}

// MARK: SymblChannel convenience initializers and mutators

public extension SymblChannel {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblChannel.self, from: data)
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
        id: String? = nil
    ) -> SymblChannel {
        return SymblChannel(
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

// MARK: - SymblDuration
public struct SymblDuration: Codable {
    public var startTime, endTime: String

    public init(startTime: String, endTime: String) {
        self.startTime = startTime
        self.endTime = endTime
    }
}

// MARK: SymblDuration convenience initializers and mutators

public extension SymblDuration {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblDuration.self, from: data)
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
        startTime: String? = nil,
        endTime: String? = nil
    ) -> SymblDuration {
        return SymblDuration(
            startTime: startTime ?? self.startTime,
            endTime: endTime ?? self.endTime
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SymblFrom
public struct SymblFrom: Codable {
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

// MARK: SymblFrom convenience initializers and mutators

public extension SymblFrom {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblFrom.self, from: data)
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
    ) -> SymblFrom {
        return SymblFrom(
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

// MARK: - SymblMetadata
public struct SymblMetadata: Codable {
    public var disablePunctuation: Bool
    public var originalContent, words, originalMessageID: String
    public var timezoneOffset: Int?

    enum CodingKeys: String, CodingKey {
        case disablePunctuation, originalContent, words
        case originalMessageID
        case timezoneOffset
    }

    public init(disablePunctuation: Bool, originalContent: String, words: String, originalMessageID: String, timezoneOffset: Int?) {
        self.disablePunctuation = disablePunctuation
        self.originalContent = originalContent
        self.words = words
        self.originalMessageID = originalMessageID
        self.timezoneOffset = timezoneOffset
    }
}

// MARK: SymblMetadata convenience initializers and mutators

public extension SymblMetadata {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblMetadata.self, from: data)
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
        disablePunctuation: Bool? = nil,
        originalContent: String? = nil,
        words: String? = nil,
        originalMessageID: String? = nil,
        timezoneOffset: Int?? = nil
    ) -> SymblMetadata {
        return SymblMetadata(
            disablePunctuation: disablePunctuation ?? self.disablePunctuation,
            originalContent: originalContent ?? self.originalContent,
            words: words ?? self.words,
            originalMessageID: originalMessageID ?? self.originalMessageID,
            timezoneOffset: timezoneOffset ?? self.timezoneOffset
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

