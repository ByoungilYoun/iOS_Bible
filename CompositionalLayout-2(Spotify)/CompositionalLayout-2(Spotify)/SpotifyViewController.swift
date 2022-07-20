//
//  SpotifyViewController.swift
//  CompositionalLayout-2(Spotify)
//
//  Created by 윤병일 on 2022/07/13.
//

import UIKit
import SnapKit

class SpotifyViewController : UIViewController {
  
  //MARK: - Properties
  
  private let titleLabel : UILabel = {
    let label = UILabel()
    label.text = "Keep Listening to Local favorite, amazing playlists, and more"
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 26, weight: .bold)
    label.textColor = .white
    return label
  }()
  
  lazy var collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  private let pageControl : UIPageControl = {
    let control = UIPageControl()
    control.numberOfPages = 3
    control.tintColor = .white
    return control
  }()

  private let getPremiumButton : UIButton = {
    let button = UIButton()
    button.setTitle("Get Preminum", for: .normal)
    button.setTitleColor(UIColor.black, for: .normal)
    button.backgroundColor = .white
    button.layer.cornerRadius = 20
    return button
  }()

  private let spotifyImageView : UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "img_spotify")
    view.contentMode = .scaleAspectFit
    return view
  }()

  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureCollectionView()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .black
    collectionView.backgroundColor = .clear
    
    [titleLabel, collectionView, pageControl, getPremiumButton, spotifyImageView].forEach {
      view.addSubview($0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
      $0.leading.trailing.equalToSuperview().inset(30)
    }
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(200)
    }
    
    pageControl.snp.makeConstraints {
      $0.top.equalTo(collectionView.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
    }
    
    getPremiumButton.snp.makeConstraints {
      $0.top.equalTo(pageControl.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
      $0.width.equalTo(180)
      $0.height.equalTo(60)
    }
    
    spotifyImageView.snp.makeConstraints {
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview().inset(40)
      $0.height.equalTo(120)
    }
  }
  
  private func configureCollectionView() {
    collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
  }
}

extension SpotifyViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else { return UICollectionViewCell() }
    return cell
  }
}

extension SpotifyViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.size.width
    let height = collectionView.frame.size.height
    return CGSize(width: width, height: height)
  }
}
