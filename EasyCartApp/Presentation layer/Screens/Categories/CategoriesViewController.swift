//
//  CategoriesViewController.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import UIKit

class CategoriesViewController: UITableViewController {

  private let viewModel: CategoriesViewModelProtocol

  init(viewModel: CategoriesViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    tableView.reloadData()
  }

  // MARK: - UI setup
  
  private func setupUI() {
    let titleView = UILabel()
    titleView.text = "Categories (\(viewModel.categories.count))"
    navigationItem.titleView = titleView
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: AppConstants.categoriesCellIdentifier)
    tableView.rowHeight = 56
    tableView.reloadData()
  }
  
  // MARK: - TableView
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.categories.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.categoriesCellIdentifier, for: indexPath)
    cell.textLabel?.text = viewModel.categories[indexPath.row].capitalizedFirstLetter
    cell.textLabel?.font = .systemFont(ofSize: 20, weight: .medium)
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    viewModel.openCategoryDetail(for: indexPath)
  }
    
}
