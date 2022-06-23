//
//  SymblConfig.swift
//  
//
//  Created by Subodh Jena on 23/06/22.
//

import Foundation

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
