//
//  ItemDetailViewContoller.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import UIKit

class ItemDetailViewContoller: UIViewController {
  
  private let item: DataModel
  private let detailView = ItemDetailView()
  
  init(item: DataModel) {
    self.item = item
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = detailView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let title = item.title?.capitalizedFirstLetter ?? ""
    let category = item.category?.capitalizedFirstLetter ?? ""
    navigationItem.title = "\(title) • \(category)"
    detailView.configure(with: item)
  }
  
}

