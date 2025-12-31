//
//  Assembly.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import UIKit

protocol CoordinatorAssembly {
  
  func makeHomeCoordinator(with navigation: UINavigationController, with category: String?) -> Coordinator
  func makeCategoriesCoordinator(with navigation: UINavigationController, with categoryList: [String]) -> Coordinator
  func makeCategoryDetailsCoordinator(with navigation: UINavigationController, with category: String?) -> Coordinator
  
}
