//
//  File.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

import Foundation

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
