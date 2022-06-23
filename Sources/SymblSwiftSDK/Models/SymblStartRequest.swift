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
