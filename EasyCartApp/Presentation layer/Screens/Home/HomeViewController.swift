//
//  HomeViewController.swift
//  iOSProject
//
//  Created by Shivam Gupta on 30/12/25.
//

import UIKit
import Combine

final class HomeViewController: UITableViewController {
  
  private let stateContainerView = UIView()
  
  private let activityIndicator = UIActivityIndicatorView(style: .large)
  
  private let errorLabel: UILabel = {
    let label = UILabel()
    label.text = AppConstants.errorMessage
    label.textAlignment = .center
    label.numberOfLines = 0
    label.textColor = .secondaryLabel
    label.isHidden = true
    return label
  }()
  
  private let viewModel: HomeViewModelProtocol
  private var cancellables = Set<AnyCancellable>()
  
  init(viewModel: HomeViewModelProtocol) {
    self.viewModel = viewModel
    super.init(style: .plain)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindViewModel()
    viewModel.loadData()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setNavigationBarButton()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationItem.title = ""
  }
  
  private func bindViewModel() {
    viewModel.subject
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { _ in },
            receiveValue: { [weak self] result in
        guard let self else { return }
        switch result {
        case .loading:
          self.tableView.backgroundView?.isHidden = false
          self.activityIndicator.startAnimating()
          self.errorLabel.isHidden = true
          
        case .loaded:
          self.activityIndicator.stopAnimating()
          self.errorLabel.isHidden = true
          self.tableView.backgroundView?.isHidden = true
          
        case .error:
          self.activityIndicator.stopAnimating()
          self.errorLabel.isHidden = false
          self.tableView.backgroundView?.isHidden = false
        }
        self.tableView.reloadData()
      })
      .store(in: &cancellables)
  }
  
  // MARK: - UI setup
  
  private func setupUI() {
    tableView.rowHeight = 100
    tableView.register(CustomTableCell.self, forCellReuseIdentifier: CustomTableCell.identifier)
    
    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(refreshTriggered), for: .valueChanged)
    tableView.refreshControl = refresh
    
    setupDataStateView()
  }
  
  private func setupDataStateView() {
    stateContainerView.frame = tableView.bounds
    
    // Loader
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    stateContainerView.addSubview(activityIndicator)
    
    // Error label
    errorLabel.translatesAutoresizingMaskIntoConstraints = false
    stateContainerView.addSubview(errorLabel)
    
    NSLayoutConstraint.activate([
      activityIndicator.centerXAnchor.constraint(equalTo: stateContainerView.centerXAnchor),
      activityIndicator.centerYAnchor.constraint(equalTo: stateContainerView.centerYAnchor),
      
      errorLabel.centerXAnchor.constraint(equalTo: stateContainerView.centerXAnchor),
      errorLabel.centerYAnchor.constraint(equalTo: stateContainerView.centerYAnchor),
      errorLabel.leadingAnchor.constraint(greaterThanOrEqualTo: stateContainerView.leadingAnchor, constant: 16),
      errorLabel.trailingAnchor.constraint(lessThanOrEqualTo: stateContainerView.trailingAnchor, constant: -16)
    ])
    
    tableView.backgroundView = stateContainerView
  }
  
  func setNavigationBarButton() {
    navigationItem.title = viewModel.navTitle
    guard viewModel.selectedCategory == nil else { return }
    let button = UIButton()
    button.setTitleColor(.link, for: .normal)
    button.setTitle(AppConstants.allCategories, for: .normal)
    button.addTarget(self, action: #selector(showCategories), for: .touchUpInside)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
  }
  
  @objc private func refreshTriggered() {
    viewModel.loadData()
    tableView.refreshControl?.endRefreshing()
  }
  
  @objc func showCategories() {
    viewModel.showCategories()
  }
  
  // MARK: - TableView
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard case .loaded(let serverData) = viewModel.subject.value else { return 0 }
    return serverData.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableCell.identifier,
                                                   for: indexPath) as? CustomTableCell,
          case .loaded(let serverData) = viewModel.subject.value else { return UITableViewCell() }
    cell.configure(model: serverData[indexPath.row])
    return cell
  }
  
  override func tableView(_ tableView: UITableView,
                          willDisplay cell: UITableViewCell,
                          forRowAt indexPath: IndexPath) {
    if case .loaded(let serverData) = viewModel.subject.value,
       indexPath.row == serverData.count - 2 {
      viewModel.fetchPaginatedData()
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    viewModel.showItemDetail(at: indexPath)
  }
  
}
