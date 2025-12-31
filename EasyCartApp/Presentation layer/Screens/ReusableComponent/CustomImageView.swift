//
//  CustomImageView.swift
//  EasyCartApp
//
//  Created by Shivam Gupta on 31/12/25.
//

import UIKit

class CustomImageView: UIImageView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  func setup() {
    contentMode = .scaleAspectFit
    self.image = UIImage(named: "placeholderImage")
  }
  
  func configure(imageUrl: String) {
    guard let url = URL(string: imageUrl) else { return }
    let request = URLRequest(url: url)
    Task {
      if let (data, _) = try? await URLSession.shared.data(for: request),
         let downloadedImage = UIImage(data: data) {
        await MainActor.run {
          self.image = downloadedImage
        }
      }
    }
  }
  
}
