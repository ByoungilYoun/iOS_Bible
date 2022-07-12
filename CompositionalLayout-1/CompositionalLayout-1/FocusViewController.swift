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
  lazy var collectionView : UICollectionView = {
    return UICollectionView(frame: .zero, collectionViewLayout: layout())
  }()
  
  var items : [Focus] = Focus.list
  
  typealias Item = Focus
  
  enum Section {
    case main
  }
  
  var dataSource : UICollectionViewDiffableDataSource<Section, Item>!
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureCollectionView()
  }
  
  //MARK: - Functions
  private func configureUI() {
    view.backgroundColor = .black
    
    view.addSubview(collectionView)
    collectionView.backgroundColor = .black
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  private func configureCollectionView(){
    collectionView.collectionViewLayout = layout()
    collectionView.register(FocusCell.self, forCellWithReuseIdentifier: FocusCell.identifier)
    setDataSource()
    makeSnapShot()
  }
  
  private func setDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FocusCell.identifier, for: indexPath) as? FocusCell else {
        return nil
      }
      cell.configure(item)
      return cell
    })
  }
  
  private func makeSnapShot() {
    var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapShot.appendSections([.main])
    snapShot.appendItems(items, toSection: .main)
    dataSource.apply(snapShot)
  }
  
  private func layout() -> UICollectionViewCompositionalLayout {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))

    
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    let section = NSCollectionLayoutSection(group: group)
    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
    section.interGroupSpacing = 10
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
}
