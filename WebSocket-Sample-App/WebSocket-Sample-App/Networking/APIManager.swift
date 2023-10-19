//
//  APIManager.swift
//  WebSocket-Sample-App
//
//  Created by Bryan Luna on 10/13/23.
//

import Combine
import Foundation

protocol WebSocketStore {
    func resumeService() 
    func pauseService()
    func listenService() async throws -> URLSessionWebSocketTask.Message
    func closeService()
}

final class APIManager {
    
    private var url: URL
    private var webSocketTask: URLSessionWebSocketTask
    
    init() {
        self.url = URL(string: "wss://ws.coincap.io/prices?assets=ALL")!
        self.webSocketTask = URLSession.shared.webSocketTask(with: url)
    }
    
    deinit {
        closeService()
    }
}

extension APIManager: WebSocketStore {
    
    func resumeService() {
        webSocketTask.resume()
    }
    
    func pauseService() {
        webSocketTask.progress.pause()
    }
    
    func listenService() async throws -> URLSessionWebSocketTask.Message {
        do {
            return try await webSocketTask.receive()
        } catch {
            throw error
        }
    }
    
    func closeService() {
        webSocketTask.cancel(with: .normalClosure, reason: nil)
    }
}
