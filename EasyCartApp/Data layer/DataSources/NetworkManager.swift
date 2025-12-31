//
//  NetworkManager.swift
//  iOSProject
//
//  Created by Shivam Gupta on 30/12/25.
//

import Network
import UserNotifications

protocol NetworkMonitorProtocol {
  func startMonitoring()
  var isConnected: Bool { get }
}

final class NetworkMonitor: NetworkMonitorProtocol {
  
  static let shared = NetworkMonitor()
  
  private let monitor = NWPathMonitor()
  private let queue = DispatchQueue(label: "NetworkMonitorQueue")
  
  private var lastStatus: NWPath.Status?
  private(set) var isConnected: Bool = true
  
  func startMonitoring() {
    
    lastStatus = monitor.currentPath.status
    isConnected = lastStatus == .satisfied
    
    monitor.pathUpdateHandler = { [weak self] path in
      guard let self else { return }
      
      guard self.lastStatus != path.status else { return }
      
      self.lastStatus = path.status
      self.isConnected = path.status == .satisfied
      
      self.triggerNotification(isConnected: self.isConnected)
    }
    
    monitor.start(queue: queue)
  }
  
  private func triggerNotification(isConnected: Bool) {
    let content = UNMutableNotificationContent()
    content.title = isConnected
    ? AppConstants.internetConnected
    : AppConstants.noInternetConnection
    
    content.body = isConnected
    ? AppConstants.backOnline
    : AppConstants.checkConnection
    
    content.sound = .default
    
    let trigger = UNTimeIntervalNotificationTrigger(
      timeInterval: 1,
      repeats: false
    )
    
    let request = UNNotificationRequest(
      identifier: UUID().uuidString,
      content: content,
      trigger: trigger
    )
    
    UNUserNotificationCenter.current().add(request)
  }
}

