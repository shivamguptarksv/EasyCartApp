//
//  MoviesListWorker.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import UIKit

protocol NetworkingManagerProtocol {
  func fetchMockData() async throws -> NetworkResponseModel
  func fetchData(page: Int, limit: Int, category: String?) async throws -> NetworkResponseModel
  
}

class NetworkingManager: NetworkingManagerProtocol {
  
  private let networkMonitor: NetworkMonitorProtocol
  private let urlString = "https://fakeapi.net/products"
  private let session: URLSession
  private let urlCache: URLCache
  private let decoder: JSONDecoder
  private let imageCache = NSCache<NSString, UIImage>()
  
  init(networkMonitor: NetworkMonitorProtocol) {
    self.networkMonitor = networkMonitor
    let configuration = URLSessionConfiguration.default
    let cache = URLCache(memoryCapacity: 50*1000*1000,
                                      diskCapacity: 50*1000*1000,
                                      diskPath: "URLCache")
    configuration.urlCache = cache
    configuration.requestCachePolicy = .returnCacheDataElseLoad
    self.session = URLSession(configuration: .default)
    self.decoder = JSONDecoder()
    self.urlCache = cache
  }
  
  private func validateNetwork() throws {
    guard networkMonitor.isConnected else {
      debugPrint("Network not available")
      throw CustomError.noInternet
    }
    debugPrint("Network available")
  }
  
  func fetchMockData() async throws -> NetworkResponseModel {
    guard let path = Bundle.main.url(forResource: "MockData", withExtension: "json") else {
      throw CustomError.incorrectMockDataPath }
    let data = try Data(contentsOf: path)
    return try decoder.decode(NetworkResponseModel.self, from: data)
  }
  
  func fetchData(page: Int = 1,
                 limit: Int = 10,
                 category: String? = nil) async throws -> NetworkResponseModel {
    guard var urlComponent = URLComponents(string: urlString) else { throw CustomError.incorrectURLComponent }
    urlComponent.queryItems = [
      URLQueryItem(name: "page", value: "\(page)"),
      URLQueryItem(name: "limit", value: "\(limit)")
    ]
    
    if let category { urlComponent.queryItems?.append(URLQueryItem(name: "category", value: "\(category)")) }
    guard let url = urlComponent.url else { throw CustomError.incorrectURL }
    
    let request = URLRequest(url: url)
    if let response = urlCache.cachedResponse(for: request) {
      return try decoder.decode(NetworkResponseModel.self, from: response.data)
    }
    
    try validateNetwork()
    let (data, res) = try await session.data(for: request)
    let cachedURLResponse = CachedURLResponse(response: res, data: data)
    urlCache.storeCachedResponse(cachedURLResponse, for: request)
    
    return try decoder.decode(NetworkResponseModel.self, from: data)
  }
  
  func loadImage(for imageUrl: String) async throws -> UIImage? {
    guard let url = URL(string: imageUrl) else { return nil }
    
    if let image = imageCache.object(forKey: imageUrl as NSString) {
      return image
    } else {
      try validateNetwork()
      
      let request = URLRequest(url: url)
      let (data, _) = try await session.data(for: request)
      if let image = UIImage(data: data) {
        imageCache.setObject(image, forKey: urlString as NSString)
      }
      return UIImage(data: data)
    }
  }
  
}
