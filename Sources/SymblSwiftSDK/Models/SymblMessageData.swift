//
//  File.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//
import Foundation

// MARK: - SymblMessageData
public struct SymblMessageData: Codable {
    public var type: String
    public var message: SymblMessage
    public var timeOffset: Int

    public init(type: String, message: SymblMessage, timeOffset: Int) {
        self.type = type
        self.message = message
        self.timeOffset = timeOffset
    }
}

// MARK: SymblMessageData convenience initializers and mutators

public extension SymblMessageData {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(SymblMessageData.self, from: data)
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
        message: SymblMessage? = nil,
        timeOffset: Int? = nil
    ) -> SymblMessageData {
        return SymblMessageData(
            type: type ?? self.type,
            message: message ?? self.message,
            timeOffset: timeOffset ?? self.timeOffset
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

