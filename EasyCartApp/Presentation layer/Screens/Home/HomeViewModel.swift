//
//  HomeViewModel.swift
//  iOSProject
//
//  Created by Shivam Gupta on 30/12/25.
//

import Foundation
import Combine
import Network

protocol HomeViewModelProtocol {
  func loadData()
  func fetchPaginatedData()
  func showCategories()
  func showItemDetail(at indexPath: IndexPath)
  var selectedCategory: String? { get }
  var navTitle: String { get }
  var subject: CurrentValueSubject<DataLoadState<[DataModel]>, Never> { get }
}

protocol HomeRoutingLogic {
  func routeToCategoryList(with categories: [String])
  func routeToItemDetail(with itemData: DataModel)
}

final class HomeViewModel: HomeViewModelProtocol {

  private let router: HomeRoutingLogic
  private let networkManager: NetworkingManagerProtocol

  // MARK: - Pagination State
  private var currentPage = 1
  private let limit = 10
  private var totalItems = 0
  var selectedCategory: String? = nil
  private var isLoading = false
  var navTitle: String = ""
  
  // MARK: - Output
  let subject = CurrentValueSubject<DataLoadState<[DataModel]>, Never>(.loading)

  init(injection: HomeCoordinatorModel.InjectionModel) {
    router = injection.router
    networkManager = injection.networkManager
    selectedCategory = injection.selectedCategory
    navTitle = selectedCategory == nil ? AppConstants.easyCartList : "\(selectedCategory?.capitalizedFirstLetter ?? AppConstants.categoryItems)"
  }

  // MARK: - Lifecycle
  
  func loadData() {
    fetchData()
  }
  
  func fetchPaginatedData() {
    guard case .loaded(let serverData) = subject.value,
            serverData.count < totalItems else { return }
    currentPage += 1
    fetchData()
  }
  
  private func fetchData() {
    guard !isLoading else { return }
    isLoading = true

    Task {
      do {
        let response = try await networkManager.fetchData(page: currentPage,
                                                          limit: limit,
                                                          category: selectedCategory)
        let newItems = response.data ?? []
        totalItems = response.pagination?.total ?? 0
        if currentPage == 1 {
          subject.send(.loaded(data: newItems))
        } else if case .loaded(let serverData) = subject.value {
          subject.send(.loaded(data: serverData + newItems))
        }
      } catch {
        subject.send(.error)
      }
      isLoading = false
    }
  }

  func showItemDetail(at indexPath: IndexPath) {
    guard case .loaded(let serverData) = subject.value,
          indexPath.row < serverData.count else { return }
    let data = serverData[indexPath.row]
    router.routeToItemDetail(with: data)
  }
  
  func showCategories() {
    guard case .loaded(let serverData) = subject.value else { return }
    let categories = Set(serverData.compactMap { $0.category }).map { $0 }.sorted()
    router.routeToCategoryList(with: categories)
  }
  
}


