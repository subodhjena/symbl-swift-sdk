//
//  File.swift
//  
//
//  Created by Subodh Jena on 22/06/22.
//

import Foundation

struct SymblStartRequest: Codable {
    let type, meetingTitle: String
    let insightTypes: [String]
    let config: SymblConfig
    let speaker: SymblSpeaker
}

struct SymblConfig: Codable {
    let confidenceThreshold: Double
    let languageCode: String
    let speechRecognition: SymblSpeechRecognition
}

struct SymblSpeechRecognition: Codable {
    let encoding: String
    let sampleRateHertz: Int
}

struct SymblSpeaker: Codable {
    let userID, name: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case name
    }
}

