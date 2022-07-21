//
//  BannerCell.swift
//  CompositionalLayout-2(Spotify)
//
//  Created by 윤병일 on 2022/07/18.
//

import UIKit
import SnapKit

class BannerCell : UICollectionViewCell {
  
  //MARK: - Properties
  
  static let identifier = "BannerCell"
  
  var mainTitleLabel : UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.numberOfLines = 2
    label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
    return label
  }()
  
  var subTitleLabel : UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    return label
  }()
  
  var cellImageView : UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFit
    return view
  }()
  
  //MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Functions
  private func configureUI() {
    layer.cornerRadius = 16
    
    [mainTitleLabel, subTitleLabel, cellImageView].forEach {
      contentView.addSubview($0)
    }
    
    mainTitleLabel.snp.makeConstraints {
      $0.leading.top.equalToSuperview().offset(30)
      $0.trailing.equalTo(cellImageView.snp.leading).offset(-30)
      $0.height.equalTo(35)
    }
    
    cellImageView.snp.makeConstraints {
      $0.top.equalTo(mainTitleLabel)
      $0.trailing.equalToSuperview().offset(-40)
      $0.width.height.equalTo(70)
    }
    
    subTitleLabel.snp.makeConstraints {
      $0.leading.equalTo(mainTitleLabel)
      $0.trailing.equalTo(mainTitleLabel)
      $0.top.equalTo(mainTitleLabel.snp.bottom).offset(20)
      $0.bottom.equalToSuperview().offset(-20)
    }
  }
  
  func configure(_ info : BannerInfo) {
    mainTitleLabel.text = info.title
    subTitleLabel.text = info.description
    cellImageView.image = UIImage(named: info.imageName)
  }
}
