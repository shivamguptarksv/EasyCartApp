//
//  ResponseModel.swift
//  iOSProject
//
//  Created by Shivam Gupta on 30/12/25.
//

import Foundation

struct NetworkResponseModel: Codable {
  let data: [DataModel]?
  let pagination: Pagination?
}

struct DataModel: Codable {
  let id: Int?
  let title: String?
  let price: Double?
  let description, category, brand: String?
  let stock: Int?
  let image: String?
  let specs: Specs?
  let rating: Rating?
}

struct Rating: Codable {
  let rate: Double?
  let count: Int?
}

struct Specs: Codable {
  let color, weight, storage, battery: String?
  let waterproof: Bool?
  let screen, ram, connection, capacity: String?
  let output: String?
}

struct Pagination: Codable {
  let page, limit, total: Int?
}
