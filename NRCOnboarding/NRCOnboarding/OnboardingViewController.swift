//
//  OnboardingViewController.swift
//  NRCOnboarding
//
//  Created by 윤병일 on 2022/07/04.
//

import UIKit
import SnapKit

class OnboardingViewController : UIViewController {
  
  //MARK: - Properties
  
  let backgroundImageView : UIImageView = {
    let view = UIImageView()
    view.contentMode = .scaleAspectFill
    view.image = UIImage(named: "img_onboarding_bg")
    return view
  }()
  
  let joinNowButton : UIButton = {
    let button = UIButton()
    button.setTitle("Join Now", for: .normal)
    button.backgroundColor = .white
    button.setTitleColor(UIColor.black, for: .normal)
    return button
  }()
  
  let loginButton : UIButton = {
    let button = UIButton()
    button.setTitle("Login", for: .normal)
    button.backgroundColor = .white
    button.setTitleColor(UIColor.black, for: .normal)
    return button
  }()
  
  let onboardingCollectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  let pageControl = UIPageControl()
  
  let messageData : [OnboardingMessage] = OnboardingMessage.messages
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureCollectionView()
  }
  
  //MARK: - Functions
  private func configureUI() {
    let stackView = UIStackView(arrangedSubviews: [joinNowButton, loginButton])
    stackView.distribution = .fillEqually
    stackView.axis = .horizontal
    stackView.spacing = 0
    
    pageControl.backgroundColor = .blue
    
    [backgroundImageView, onboardingCollectionView, pageControl, stackView].forEach {
      view.addSubview($0)
    }
    
    backgroundImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    onboardingCollectionView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(stackView.snp.top).offset(-100)
    }
    
    pageControl.snp.makeConstraints {
      $0.bottom.equalTo(stackView.snp.top).offset(-50)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(30)
    }
    
    stackView.snp.makeConstraints {
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }
  }
  
  private func configureCollectionView() {
    onboardingCollectionView.backgroundColor = .clear
    onboardingCollectionView.showsHorizontalScrollIndicator = false
    onboardingCollectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
    onboardingCollectionView.dataSource = self
    onboardingCollectionView.delegate = self
    onboardingCollectionView.isPagingEnabled = true
  }
}

//MARK: - UICollectionViewDataSource
extension OnboardingViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messageData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else {
      return UICollectionViewCell()
    }
    cell.configure(messageData[indexPath.item])
    return cell
  }
}

//MARK: - UICollectionViewDelegate
extension OnboardingViewController : UICollectionViewDelegate {
  
}

//MARK: - UICollectionViewDelegateFlowLayout
extension OnboardingViewController : UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return collectionView.bounds.size
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return .zero
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return .zero
  }
}
