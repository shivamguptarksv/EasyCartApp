//
//  CategoriesViewModel.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import Foundation

protocol CategoriesViewModelProtocol {
  var categories: [String] { get }
  func openCategoryDetail(for indexPath: IndexPath)
}

protocol CategoryViewRouter {
  func routeToCategoryDetail(for category: String)
}

final class CategoriesViewModel: CategoriesViewModelProtocol {

  private let router: CategoryViewRouter
  var categories: [String]

  init(router: CategoryViewRouter, categories: [String]) {
    self.router = router
    self.categories = categories
  }
  
  func openCategoryDetail(for indexPath: IndexPath) {
    guard indexPath.row < categories.count else { return }
    router.routeToCategoryDetail(for: categories[indexPath.row])
  }
  
}

