//
//  CustomTableCell.swift
//  iOSProject
//
//  Created by Shivam Gupta on 30/12/25.
//

import UIKit

class CustomTableCell: UITableViewCell {
  
  static let identifier = "CustomTableCell"
  
  private let iconView: CustomImageView = {
    let iconView = CustomImageView(frame: .init(origin: .zero, size: .init(width: 24, height: 24)))
    return iconView
  }()
  
  private let mainStack: UIStackView = {
    let mainStack = UIStackView()
    mainStack.axis = .vertical
    mainStack.spacing = 2
    return mainStack
  }()
  
  private let horizontalStack: UIStackView = {
    let mainStack = UIStackView()
    mainStack.axis = .horizontal
    mainStack.distribution = .equalSpacing
    return mainStack
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    return label
  }()
  
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.font = .systemFont(ofSize: 20, weight: .semibold)
    return label
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.numberOfLines = 2
    label.font = .systemFont(ofSize: 12, weight: .regular)
    return label
  }()
  
  private let categoryLabel: UILabel = {
    let label = UILabel()
    label.textColor = .label
    label.font = .systemFont(ofSize: 16, weight: .regular)
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  func setup() {
    horizontalStack.addArrangedSubview(titleLabel)
    horizontalStack.addArrangedSubview(priceLabel)
    
    mainStack.addArrangedSubview(horizontalStack)
    mainStack.addArrangedSubview(descriptionLabel)
    mainStack.addArrangedSubview(categoryLabel)

    [iconView, mainStack].forEach { customView in
      contentView.addSubview(customView)
      customView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      
      iconView.heightAnchor.constraint(equalToConstant: 24),
      iconView.widthAnchor.constraint(equalToConstant: 24),
      
      mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
      mainStack.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16)
    ])
    
  }
  
  func configure(model: DataModel?) {
    guard let model else { return }
    iconView.configure(imageUrl: model.image ?? "")
    titleLabel.text = model.title
    priceLabel.text = "$\(model.price ?? .zero)"
    descriptionLabel.text = model.description
    categoryLabel.text = "Category: \(model.category?.capitalizedFirstLetter ?? "")"
  }
  
}


 
 /*
 ● Tableview cell should have title, description, category, price and image

 ┌───────────────────────────────────────┐
 │ 🖼️  Title                    ₹499     │
 │     Description goes here (2 lines)   │
 │     [Category]                        │
 └───────────────────────────────────────┘

 */
