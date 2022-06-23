//
//  File.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

import Foundation

// MARK: - SymblTopicResponse
public struct SymblTopicResponse: Codable {
    public var type: String?
    public var topics: [SymblTopic]?

    public init(type: String?, topics: [SymblTopic]?) {
        self.type = type
        self.topics = topics
    }
}

// MARK: SymblTopicResponse convenience initializers and mutators

public extension SymblTopicResponse {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblTopicResponse.self, from: data)
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
        type: String?? = nil,
        topics: [SymblTopic]?? = nil
    ) -> SymblTopicResponse {
        return SymblTopicResponse(
            type: type ?? self.type,
            topics: topics ?? self.topics
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SymblTopic
public struct SymblTopic: Codable {
    public var id: String?
    public var messageReferences: [SymblMessageReference]?
    public var phrases: String?
    public var rootWords: [SymblRootWord]?
    public var score: Double?
    public var type: String?
    public var messageIndex: Int?

    public init(id: String?, messageReferences: [SymblMessageReference]?, phrases: String?, rootWords: [SymblRootWord]?, score: Double?, type: String?, messageIndex: Int?) {
        self.id = id
        self.messageReferences = messageReferences
        self.phrases = phrases
        self.rootWords = rootWords
        self.score = score
        self.type = type
        self.messageIndex = messageIndex
    }
}

// MARK: SymblTopic convenience initializers and mutators

public extension SymblTopic {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblTopic.self, from: data)
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
        messageReferences: [SymblMessageReference]?? = nil,
        phrases: String?? = nil,
        rootWords: [SymblRootWord]?? = nil,
        score: Double?? = nil,
        type: String?? = nil,
        messageIndex: Int?? = nil
    ) -> SymblTopic {
        return SymblTopic(
            id: id ?? self.id,
            messageReferences: messageReferences ?? self.messageReferences,
            phrases: phrases ?? self.phrases,
            rootWords: rootWords ?? self.rootWords,
            score: score ?? self.score,
            type: type ?? self.type,
            messageIndex: messageIndex ?? self.messageIndex
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SymblRootWord
public struct SymblRootWord: Codable {
    public var text: String?

    public init(text: String?) {
        self.text = text
    }
}

// MARK: SymblRootWord convenience initializers and mutators

public extension SymblRootWord {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblRootWord.self, from: data)
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
        text: String?? = nil
    ) -> SymblRootWord {
        return SymblRootWord(
            text: text ?? self.text
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
