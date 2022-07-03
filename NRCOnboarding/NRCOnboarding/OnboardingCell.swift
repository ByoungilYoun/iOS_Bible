//
//  OnboardingCell.swift
//  NRCOnboarding
//
//  Created by 윤병일 on 2022/07/04.
//

import UIKit
import SnapKit

class OnboardingCell : UICollectionViewCell {
  
  //MARK: - Property
  
  static let identifier = "OnboardingCell"
  
  var imageView : UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFill
    view.clipsToBounds = true
    view.backgroundColor = .lightGray
    return view
  }()
  
  var firstLabel : UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.text = "asdfasdfasdfadsf"
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  var secondLabel : UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.numberOfLines = 0
    label.text = "asdfasdfasdfasfasfsdfasdfasfasdfasdfdfa"
    label.textAlignment = .center
    return label
  }()
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func configureUI(){
    backgroundColor = .clear
    
    [imageView, firstLabel, secondLabel].forEach {
      contentView.addSubview($0)
    }
    
    imageView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(40)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(300)
    }
    
    firstLabel.snp.makeConstraints {
      $0.top.equalTo(imageView.snp.bottom).offset(50)
      $0.leading.trailing.equalToSuperview().inset(20)
    }
    
    secondLabel.snp.makeConstraints {
      $0.top.equalTo(firstLabel).offset(50)
      $0.leading.trailing.equalToSuperview().inset(20)
    }
  }
  
  func configure(_ message : OnboardingMessage) {
    imageView.image = UIImage(named: message.imageName)
    firstLabel.text = message.title
    secondLabel.text = message.description
  }
}
