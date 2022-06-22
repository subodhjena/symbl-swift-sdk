//
//  SymblSwiftSDK.swift
//
//
//  Created by Subodh Jena on 21/06/22.
//

import Foundation

public struct Symbl {
    private var _acessToken = ""
    
    public init(accessToken: String) {
        _acessToken = accessToken
    }
    
    public func initializeRealtimeApi() throws -> SymblRealtimeApi {
        if(_acessToken.isEmpty) {
            throw SymblError.invalidAccessToken
        }
        
        return SymblRealtimeApi()
    }
}


enum SymblError: Error {
    case invalidAccessToken
    case expiredAccessToken
}
