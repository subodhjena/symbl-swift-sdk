//
//  File.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

import Foundation

// MARK: - SymblStartRequest
public struct SymblStartRequest: Codable {
    public var insightTypes: [String]
    public var meetingTitle: String
    public var config: SymblConfig
    public var speaker: SymblSpeaker
    public var type: String

    public init(insightTypes: [String], meetingTitle: String, config: SymblConfig, speaker: SymblSpeaker, type: String) {
        self.insightTypes = insightTypes
        self.meetingTitle = meetingTitle
        self.config = config
        self.speaker = speaker
        self.type = type
    }
}

// MARK: SymblStartRequest convenience initializers and mutators

public extension SymblStartRequest {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblStartRequest.self, from: data)
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
        insightTypes: [String]? = nil,
        meetingTitle: String? = nil,
        config: SymblConfig? = nil,
        speaker: SymblSpeaker? = nil,
        type: String? = nil
    ) -> SymblStartRequest {
        return SymblStartRequest(
            insightTypes: insightTypes ?? self.insightTypes,
            meetingTitle: meetingTitle ?? self.meetingTitle,
            config: config ?? self.config,
            speaker: speaker ?? self.speaker,
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SymblConfig
public struct SymblConfig: Codable {
    public var speechRecognition: SymblSpeechRecognition
    public var confidenceThreshold: Double
    public var languageCode: String

    public init(speechRecognition: SymblSpeechRecognition, confidenceThreshold: Double, languageCode: String) {
        self.speechRecognition = speechRecognition
        self.confidenceThreshold = confidenceThreshold
        self.languageCode = languageCode
    }
}

// MARK: SymblConfig convenience initializers and mutators

public extension SymblConfig {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblConfig.self, from: data)
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
        speechRecognition: SymblSpeechRecognition? = nil,
        confidenceThreshold: Double? = nil,
        languageCode: String? = nil
    ) -> SymblConfig {
        return SymblConfig(
            speechRecognition: speechRecognition ?? self.speechRecognition,
            confidenceThreshold: confidenceThreshold ?? self.confidenceThreshold,
            languageCode: languageCode ?? self.languageCode
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - SymblSpeechRecognition
public struct SymblSpeechRecognition: Codable {
    public var encoding: String
    public var sampleRateHertz: Int

    public init(encoding: String, sampleRateHertz: Int) {
        self.encoding = encoding
        self.sampleRateHertz = sampleRateHertz
    }
}

// MARK: SymblSpeechRecognition convenience initializers and mutators

public extension SymblSpeechRecognition {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblSpeechRecognition.self, from: data)
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
        encoding: String? = nil,
        sampleRateHertz: Int? = nil
    ) -> SymblSpeechRecognition {
        return SymblSpeechRecognition(
            encoding: encoding ?? self.encoding,
            sampleRateHertz: sampleRateHertz ?? self.sampleRateHertz
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

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

// MARK: - SymblStopRequest
public struct SymblStopRequest: Codable {
    public var type: String

    public init(type: String) {
        self.type = type
    }
}

// MARK: SymblStopRequest convenience initializers and mutators

public extension SymblStopRequest {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblStopRequest.self, from: data)
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
        type: String? = nil
    ) -> SymblStopRequest {
        return SymblStopRequest(
            type: type ?? self.type
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
