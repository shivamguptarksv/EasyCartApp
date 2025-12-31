//
//  HomeCoordinatorModel.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import Foundation

struct HomeCoordinatorModel {
  
  struct InjectionModel {
    let router: HomeRoutingLogic
    let networkManager: NetworkingManagerProtocol
    let selectedCategory: String?
  }
  
}
