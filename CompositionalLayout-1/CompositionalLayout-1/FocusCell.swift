//
//  FocusCell.swift
//  CompositionalLayout-1
//
//  Created by 윤병일 on 2022/07/07.
//

import UIKit
import SnapKit

class FocusCell : UICollectionViewCell {
  
  //MARK: - Properties
  
  static let identifier = "FocusCell"
  
  let titleLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    label.text = "asdfasdfasdf"
    label.numberOfLines = 0
    label.textColor = .white
    return label
  }()
  
  let descriptionLabel : UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 17)
    label.textColor = .lightGray
    label.text = "adsfasdfasdfasdfasfdsd\nasdfadsfasdfasdf\nasdfasdfasfasdasdfasdf"
    label.numberOfLines = 0
    return label
  }()
  
  let imageView : UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    view.clipsToBounds = true
    return view
  }()
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: .zero)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func configureUI() {
    contentView.backgroundColor = UIColor.systemIndigo
    contentView.layer.cornerRadius = 20
    
    [titleLabel, descriptionLabel, imageView].forEach {
      contentView.addSubview($0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(30)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.lessThanOrEqualTo(imageView.snp.leading).offset(-30)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.leading.equalTo(titleLabel)
      $0.top.equalTo(titleLabel.snp.bottom).offset(12)
      $0.trailing.equalTo(titleLabel)
      $0.bottom.equalToSuperview().inset(30)
    }
    
    imageView.snp.makeConstraints {
      $0.top.trailing.bottom.equalToSuperview()
      $0.width.equalTo(150)
    }
  }
  
  func configure(_ item : Focus) {
    titleLabel.text = item.title
    descriptionLabel.text = item.description
    imageView.image = UIImage(systemName: item.imageName)?.withRenderingMode(.alwaysOriginal)
  }
}
