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
    return UICollectionView(frame: .zero, collectionViewLayout: layout())
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
  
  let bannerInfos : [BannerInfo] = BannerInfo.list
  
  let colors : [UIColor] = [.systemPurple, .systemOrange, .systemPink, .systemRed]
  
  typealias Item = BannerInfo
  
  enum Section {
    case main
  }
  
  var dataSource : UICollectionViewDiffableDataSource<Section, Item>!

  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureCollectionView()
    
    // presentation : diffable datasource
    
    // data : snapshot
    
    // layout : compositional layout
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
    collectionView.collectionViewLayout = layout()
    collectionView.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.identifier)
    setDataSource()
    makeSnapShot()
  }
  
  private func setDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.identifier, for: indexPath) as? BannerCell else {
        return nil
      }
      cell.configure(item)
      cell.backgroundColor = self.colors[indexPath.item]
      return cell
    })
  }
  
  private func makeSnapShot() {
    var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
    snapShot.appendSections([.main])
    snapShot.appendItems(bannerInfos, toSection: .main)
    dataSource.apply(snapShot)
  }
  
  private func layout() -> UICollectionViewCompositionalLayout {
    
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(200))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
//    section.orthogonalScrollingBehavior = .continuous // 현재 section 의 넓이에 구애받지 않고 옆으로 그냥 쭉 나열하라.
    section.orthogonalScrollingBehavior = .groupPagingCentered // 알아서 가운대로 위치시킨다.
    section.interGroupSpacing = 20
    
    let layout = UICollectionViewCompositionalLayout(section: section)
    return layout
  }
}
