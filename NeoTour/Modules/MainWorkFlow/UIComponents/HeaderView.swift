//
//  HeaderView.swift
//  NeoTour
//
//  Created by anjella on 20/2/24.
//

import UIKit
import SnapKit

class HeaderView: UICollectionReusableView, ReuseIdentifying {

  let label: UILabel = {
    let label = UILabel()
    label.adjustsFontForContentSizeCategory = true
    label.font = UIFont(name: "Avenir Next Bold", size: 20)
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension HeaderView {
  func configure() {
    backgroundColor = .systemBackground

    addSubview(label)
    label.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(10)
      make.trailing.equalToSuperview().offset(-10)
      make.top.equalToSuperview().offset(10)
      make.bottom.equalToSuperview().offset(-10)
    }
  }
}
