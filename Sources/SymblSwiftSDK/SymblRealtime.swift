//
//  SymblRealtime.swift
//  
//
//  Created by Subodh Jena on 21/06/22.
//

import Foundation

public class SymblRealtime: NSObject, URLSessionWebSocketDelegate {
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
    
    var webSocketTask: URLSessionWebSocketTask?
    weak var delegate: SymblRealtimeDelegate?
    
    init(accessToken: String, uniqueMeetingId: String) {
        _accessToken = accessToken
        _uniqueMeetingId = uniqueMeetingId
    }
    
    public func connect() {
        let symblEndpoint = "wss://api.symbl.ai/v1/streaming/\(_uniqueMeetingId)?access_token=\(_accessToken)"
        
        let webSocketURLSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let webSocketURL = URL(string: symblEndpoint)!
        
        self.webSocketTask = webSocketURLSession.webSocketTask(with: webSocketURL)
        self.webSocketTask?.resume()
    }
    
    public func disconnect() {
        let reason = "Closing connection".data(using: .utf8)
        self.webSocketTask?.cancel(with: .goingAway, reason: reason)
    }
    
    public func startRequest(startRequest: SymblStartRequest) {
        if(isConnected) {
            do {
                let startRequestJson = try startRequest.jsonString()!
                DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                    self.webSocketTask!.send(.string(startRequestJson)) { error in
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
                    self.webSocketTask!.send(.string(stopRequestJson)) { error in
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
            self.webSocketTask!.send(message) { error in
                if let error = error {
                    print("Symbl WebSocket Streaming Error: \(error)")
                }
            }
            
        }
    }
    
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        print("SymblRealtimeApi: Symbl WebSocket Connected")
        self.delegate?.symblRealtimeConnected()
        self.readMessage()
        self._isConnected = true
    }
    
    public func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        self.delegate?.symblRealtimeDisonnected()
        self._isConnected = true
    }
    
    func readMessage()  {
        webSocketTask!.receive { result in
            switch result {
            case .failure(let error):
                print("Failed to receive message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    do {
                        let symblData = try SymblData(text)
                        
                        if(symblData.type == "message") {
                            let symblMessageData = try SymblMessageData(text)
                            self.delegate!.symblReceivedMessage(message: symblMessageData.message)
                        }
                        else if(symblData.type == "message_response") {
                            let symblMessageResponse = try SymblMessageResponse(text)
                            self.delegate!.symblReceivedMessageResponse(messageResponse: symblMessageResponse)
                        }
                        else if(symblData.type == "insight_response") {
                            let symblInsightResponse = try SymblInsightResponse(text)
                            
                            // Questions
                            let questions = symblInsightResponse.insights.filter { $0.type == "question" }
                            if(!questions.isEmpty) {
                                self.delegate?.symblReceivedQuestions(questions: questions)
                            }
                            
                            // Action Items
                            let actionItems = symblInsightResponse.insights.filter { $0.type == "action_item" }
                            if(!actionItems.isEmpty) {
                                self.delegate?.symblReceivedActionItems(actionItems: actionItems)
                            }
                            
                            // Follow Ups
                            let followUps = symblInsightResponse.insights.filter { $0.type == "follow_up" }
                            if(!followUps.isEmpty) {
                                self.delegate?.symblReceivedFollowUps(followUps: followUps)
                            }
                        }
                        else if(symblData.type == "topic_response") {
                            let symblTopicResponse = try SymblTopicResponse(text)
                            self.delegate!.symblReceivedToipcResponse(topicResponse: symblTopicResponse)
                        }
                    } catch {
                        print(error)
                    }
                case .data(let data):
                    print("Received binary message: \(data)")
                @unknown default:
                    fatalError()
                }
            }
            
            self.readMessage()
        }
    }
}

public enum Message {
    case data(Data)
    case string(String)
}

public protocol SymblRealtimeDelegate: AnyObject {
    func symblRealtimeConnected()
    func symblRealtimeDisonnected()
    func symblReceivedMessage(message: SymblMessage)
    func symblReceivedMessageResponse(messageResponse: SymblMessageResponse)
    func symblReceivedToipcResponse(topicResponse: SymblTopicResponse)
    func symblReceivedActionItems(actionItems: [SymblInsight])
    func symblReceivedQuestions(questions: [SymblInsight])
    func symblReceivedFollowUps(followUps: [SymblInsight])
}
