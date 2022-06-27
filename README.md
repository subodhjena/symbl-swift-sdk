![Symbl](https://avatars.githubusercontent.com/u/61848556)

# Symbl Swift SDK

[![Build and Test](https://github.com/subodhjena/symbl-swift-sdk/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/subodhjena/symbl-swift-sdk/actions/workflows/build-and-test.yml)

Swift SDK to add symbl's api cababilities to your iOS, iPad and Mac apps

## Features

- [Streaming](https://docs.symbl.ai/docs/streamingapi/introduction)

## Demo app

A sample iOS built using this SDK could be found here - https://github.com/subodhjena/symbl-demo-ios

## Installation

Please use Swift Package Manager

Repository address: `git@github.com:subodhjena/symbl-swift-sdk.git` or <https://github.com/subodhjena/symbl-swift-sdk.git>

## Usage

Follow the below steps

Initialize the SDK

```swift
let symbl = Symbl(accessToken: accessToken)
```

Implement the delegate to start receiving data, remember to implement the protocol methods, they receive all the conversation intellegence

```swift
class SymblDelegate: SymblRealtimeDelegate {
    func symblRealtimeConnected() { print("Connected") }
    func symblRealtimeDisonnected() { print("Disconncted")}
    func symblReceivedMessage(message: SymblMessage){ print("Message") }
    func symblReceivedMessageResponse(messageResponse:SymblMessageResponse) { print("MessageResponse") }
    func symblReceivedToipcResponse(topicResponse:SymblTopicResponse){ print("TopicResponse") }
    func symblReceivedActionItems(actionItems: [SymblInsight]) { print("Action Items") }
    func symblReceivedQuestions(questions: [SymblInsight]) { print("Questions") }
    func symblReceivedFollowUps(followUps: [SymblInsight]) { print("Follow ups") }
}
```

Initialize the realtime session

```swift
// Create the delegte to start receiving data
let symblRealtimeDelegate = SymblDelegate()

// Initialize the realtime streaming session
symbl.initializeRealtimeSession(meetingId: uniqueMeetingId, delegate: symblRealtimeDelegate)

// Connect the realtime streaming session
symbl.realtimeSession.connect()
```

Start request

```swift
// Sample iOS request
// Pass in an instance of start request

let startRequest = SymblStartRequest (...)
symbl.realtimeSession.startRequest(startRequest)
```

You can pass the audio chunks to streamAudio() function and start getting the analytics

```swift
symbl.realtimeSession.streamAudio(data: data)
```

Make sure to stop the connection before closing the streaming session

```swift
symbl.realtimeSession.disconnect()
```
