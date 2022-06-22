//
//  SymblSwiftSDK.swift
//
//
//  Created by Subodh Jena on 21/06/22.
//

import Foundation

public class Symbl {
    private var _acessToken: String
    public var accessToken: String {
        return _acessToken
    }
    
    private var _realtimeSession: SymblRealtimeApi?
    public var realtimeSession: SymblRealtimeApi? {
        return _realtimeSession
    }
    
    public init(accessToken: String) {
        _acessToken = accessToken
    }
    
    public func initializeRealtimeSession(meetingId: String, delegate: SymblRealtimeDelegate) {
        _realtimeSession = SymblRealtimeApi(accessToken: self.accessToken, uniqueMeetingId: meetingId)
        _realtimeSession?.delegate = delegate
    }
}
