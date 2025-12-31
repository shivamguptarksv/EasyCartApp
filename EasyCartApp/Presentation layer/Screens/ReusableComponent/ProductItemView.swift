//
//  ProductItemView.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 30/12/25.
//

import UIKit

final class ItemDetailView: UIView {
  
  // MARK: - UI Components
  
  private let scrollView = UIScrollView()
  private let contentStack = UIStackView()
  
  private let productImageView = CustomImageView(frame: .zero)
  private let titleLabel = UILabel()
  private let subtitleLabel = UILabel()
  private let ratingLabel = UILabel()
  
  private let priceLabel = UILabel()
  private let stockLabel = UILabel()
  
  private let descriptionTitleLabel = UILabel()
  private let descriptionLabel = UILabel()
  
  private let specsTitleLabel = UILabel()
  private let specsLabel = UILabel()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UI Setup
  private func setupUI() {
    backgroundColor = .systemBackground
    
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    contentStack.translatesAutoresizingMaskIntoConstraints = false
    
    contentStack.axis = .vertical
    contentStack.spacing = 16
    
    addSubview(scrollView)
    scrollView.addSubview(contentStack)
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
      contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
      contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
      contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
      contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
    ])
    
    setupImage()
    setupLabels()
  }
  
  private func setupImage() {
    productImageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
    productImageView.layer.cornerRadius = 12
    productImageView.clipsToBounds = true
    contentStack.addArrangedSubview(productImageView)
  }
  
  private func setupLabels() {
    titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
    titleLabel.numberOfLines = 0
    
    subtitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
    subtitleLabel.textColor = .secondaryLabel
    
    ratingLabel.font = .systemFont(ofSize: 14, weight: .medium)
    
    priceLabel.font = .systemFont(ofSize: 24, weight: .bold)
    priceLabel.textColor = .systemGreen
    
    stockLabel.font = .systemFont(ofSize: 14, weight: .medium)
    
    descriptionTitleLabel.text = AppConstants.description
    descriptionTitleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
    
    descriptionLabel.font = .systemFont(ofSize: 15)
    descriptionLabel.numberOfLines = 0
    
    specsTitleLabel.text = AppConstants.specifications
    specsTitleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
    
    specsLabel.font = .systemFont(ofSize: 15)
    specsLabel.numberOfLines = 0
    
    [titleLabel,
     subtitleLabel,
     ratingLabel,
     priceLabel,
     stockLabel,
     descriptionTitleLabel,
     descriptionLabel,
     specsTitleLabel,
     specsLabel].forEach { contentStack.addArrangedSubview($0) }
  }
  
  // MARK: - Public Configure Method
  
  func configure(with item: DataModel) {
    titleLabel.text = item.title
    subtitleLabel.text = "\(item.brand ?? "") • \(item.category?.capitalized ?? "")"
    
    ratingLabel.text = "⭐ \(item.rating?.rate ?? 0) (\(item.rating?.count ?? 0) reviews)"
    
    priceLabel.text = "₹ \(item.price ?? 0)"
    
    let stock = item.stock ?? 0
    stockLabel.text = stock > 0 ? "In Stock (\(stock) left)" : AppConstants.outOfStock
    stockLabel.textColor = stock > 0 ? .systemGreen : .systemRed
    
    descriptionLabel.text = item.description
    
    specsLabel.text = """
    • Color: \(item.specs?.color ?? "-")
    • Weight: \(item.specs?.weight ?? "-")
    • Storage: \(item.specs?.storage ?? "-")
    """
    
    productImageView.configure(imageUrl: item.image ?? "")
  }

}

/*
 
 ┌──────────────────────────┐
 │        Product Image     │
 ├──────────────────────────┤
 │ Smartphone X             │
 │ TechCo • Electronics     │
 │ ⭐ 4.5 (120 reviews)     │
 │                          │
 │ ₹ 799.99                 │
 │ In Stock (50 left)       │
 ├──────────────────────────┤
 │ Description              │
 │ Latest smartphone with…  │
 ├──────────────────────────┤
 │ Specifications           │
 │ • Color: Black           │
 │ • Weight: 180g           │
 │ • Storage: 128GB         │
 └──────────────────────────┘
 
 */
