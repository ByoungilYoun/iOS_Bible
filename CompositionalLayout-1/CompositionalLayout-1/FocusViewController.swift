//
//  FocusViewController.swift
//  CompositionalLayout-1
//
//  Created by 윤병일 on 2022/07/07.
//

import UIKit
import SnapKit

class FocusViewController : UIViewController {
  
  //MARK: - Properties
  let collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .white
    
    view.addSubview(collectionView)
    collectionView.backgroundColor = .blue
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  //MARK: - @objc func
  
}
