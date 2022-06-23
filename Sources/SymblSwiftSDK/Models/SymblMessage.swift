//
//  SymblMessage.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

import Foundation

// MARK: - SymblMessage
public struct SymblMessage: Codable {
    public var type: String
    public var data: SymblConversationData?
    public var isFinal: Bool?
    public var payload: SymblPayload?
    public var punctuated: SymblPunctuated?
    public var user: SymblUser?
    
    // SymbMessageResponse
    public var id: String?
    public var from: SymblFrom?
    public var channel: SymblChannel?
    public var metadata: SymblMetadata?
    public var dismissed: Bool?
    public var duration: SymblDuration?

    public init(type: String, data: SymblConversationData, isFinal: Bool, payload: SymblPayload, punctuated: SymblPunctuated, user: SymblUser, id: String, from: SymblFrom, channel: SymblChannel, metadata: SymblMetadata, dismissed: Bool, duration: SymblDuration) {
        self.type = type
        self.data = data
        self.isFinal = isFinal
        self.payload = payload
        self.punctuated = punctuated
        self.user = user
        
        // SymbMessageResponse
        self.id = id
        self.from = from
        self.channel = channel
        self.metadata = metadata
        self.dismissed = dismissed
        self.duration = duration
    }
}

// MARK: SymblMessage convenience initializers and mutators

public extension SymblMessage {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblMessage.self, from: data)
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
        data: SymblConversationData? = nil,
        isFinal: Bool? = nil,
        payload: SymblPayload? = nil,
        punctuated: SymblPunctuated? = nil,
        user: SymblUser? = nil,
        id: String?  = nil,
        from: SymblFrom? = nil,
        channel: SymblChannel? = nil,
        metadata: SymblMetadata? = nil,
        dismissed: Bool? = nil,
        duration: SymblDuration? = nil
    ) -> SymblMessage {
        return SymblMessage(
            type: type ?? self.type,
            data: data ?? self.data!,
            isFinal: isFinal ?? self.isFinal!,
            payload: payload ?? self.payload!,
            punctuated: punctuated ?? self.punctuated!,
            user: user ?? self.user!,
            id: id ?? self.id!,
            from: from ?? self.from!,
            channel: channel ?? self.channel!,
            metadata: metadata ?? self.metadata!,
            dismissed: dismissed ?? self.dismissed!,
            duration: duration ?? self.duration!
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
