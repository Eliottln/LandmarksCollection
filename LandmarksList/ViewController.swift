//
//  ViewController.swift
//  LandmarksList
//
//  Created by lpiem on 01/02/2023.
//

import UIKit

class ViewController: UICollectionViewController {
    
    enum Section: Hashable {
        case category(Landmark.Category)
    }
    
    enum Item: Hashable {
        case landmark(Landmark)
    }
    
    var landmarks = Service.shared.loadLandmarks()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.collectionViewLayout = createLayout()
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .landmark(let landmark):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
                cell.image.image = landmark.image
                cell.label.text = landmark.name
                return cell
            }
        })
        
        let snapshot = createSnapshot()
        dataSource.apply(snapshot)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex,_) -> NSCollectionLayoutSection? in
            guard let self = self,
                  let section = self.dataSource.sectionIdentifier(for: sectionIndex) else {
                return nil
            }
            
            switch section {
            case .category(.lakes):
                let dimension = NSCollectionLayoutDimension.absolute(44)
                let itemSize = NSCollectionLayoutSize(widthDimension: dimension,
                                                      heightDimension: dimension)
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(44))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .category(.mountains):
                let dimension = NSCollectionLayoutDimension.absolute(44)
                let itemSize = NSCollectionLayoutSize(widthDimension: dimension,
                                                      heightDimension: dimension)
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(44))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            case .category(.rivers):
                let dimension = NSCollectionLayoutDimension.absolute(44)
                let itemSize = NSCollectionLayoutSize(widthDimension: dimension,
                                                      heightDimension: dimension)
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(44))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
        
        return layout
    }
    
    private func createSnapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        Landmark.Category.allCases.forEach { category in
            snapshot.appendSections([.category(category)])
            let filteredLandmark = landmarks.filter { landmark in
                if (landmark.category == category) {
                    return true
                } else {
                    return false
                }
            }
            let items = filteredLandmark.map { landmark in
                return Item.landmark(landmark)
            }
            snapshot.appendItems(items)
        }
        return snapshot
    }
    
    
}

