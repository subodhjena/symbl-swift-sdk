//
//  SymblRealtime.swift
//  
//
//  Created by Subodh Jena on 21/06/22.
//

import Foundation

public class SymblRealtimeApi: NSObject, URLSessionWebSocketDelegate {
    private var _accessToken: String
    public var accessToken: String {
        set { _accessToken = newValue }
        get { return _accessToken }
    }
    
    private var _uniqueMeetingId: String
    public var uniqueMeetingId: String {
        set { _uniqueMeetingId = newValue }
        get { return _uniqueMeetingId }
    }
    
    private var _isConnected: Bool = false
    public var isConnected: Bool {
        get { return _isConnected }
    }
    
    private var _urlSessionWebSocketTask: URLSessionWebSocketTask?
    weak var delegate: SymblRealtimeDelegate?
    
    
    init(accessToken: String, uniqueMeetingId: String) {
        _accessToken = accessToken
        _uniqueMeetingId = uniqueMeetingId
    }
    
    public func connect() {
        print("SymblRealtimeApi: Connect()")
        let symblEndpoint = "wss://api.symbl.ai/v1/streaming/\(_uniqueMeetingId)?access_token=\(_accessToken)"
        
        let webSocketURLSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let webSocketURL = URL(string: symblEndpoint)!
        
        self._urlSessionWebSocketTask = webSocketURLSession.webSocketTask(with: webSocketURL)
        self._urlSessionWebSocketTask?.resume()
    }
    
    public func disconnect() {
        print("SymblRealtimeApi: Disconnect()")
        self._urlSessionWebSocketTask?.cancel(with: .goingAway, reason: nil)
    }
    
    public func startRequest(startRequest: SymblStartRequest) {
        if(isConnected) {
            do {
                let startRequestJson = try startRequest.jsonString()!
                DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                    self._urlSessionWebSocketTask!.send(.string(startRequestJson)) { error in
                        if let error = error {
                            print("Error when sending a message \(error)")
                        }
                    }
                }
            } catch let err {
                print("Failed to encode JSON \(err)")
            }
        }
    }
    
    public func stopRequest() {
        if(isConnected) {
            let stopRequest = SymblStopRequest(type: "stop_request")

            do {
                let stopRequestJson = try stopRequest.jsonString()!
                DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                    self._urlSessionWebSocketTask!.send(.string(stopRequestJson)) { error in
                        if let error = error {
                            print("Error when sending a message \(error)")
                        }
                    }
                }
            } catch let err {
                print("Failed to encode JSON \(err)")
            }
        }
    }
    
    public func streamAudio(data: Data) {
        if isConnected {
            let message = URLSessionWebSocketTask.Message.data(data)
            self._urlSessionWebSocketTask!.send(message) { error in
                if let error = error {
                    print("Symbl WebSocket Streaming Error: \(error)")
                }
            }
            
        }
    }
    
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("SymblRealtimeApi: Symbl WebSocket Connected")
        self.readMessage()
        self.delegate?.symblRealtimeConnected()
        self._isConnected = true
    }
    
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("SymblRealtimeApi: Symbl WebSocket Disconnected")
        self.delegate?.symblRealtimeDisonnected()
        self._isConnected = true
    }
    
    func readMessage()  {
        _urlSessionWebSocketTask?.receive { result in
            switch result {
            case .failure(let error):
                print("Failed to receive message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    print("Received text message: \(text)")
                case .data(let data):
                    print("Received binary message: \(data)")
                @unknown default:
                    fatalError()
                }
                
                self.readMessage()
            }
        }
    }
}

public protocol SymblRealtimeDelegate: AnyObject {
    func symblRealtimeConnected()
    func symblRealtimeDisonnected()
}
