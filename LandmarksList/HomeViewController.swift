//
//  ViewController.swift
//  LandmarksList
//
//  Created by lpiem on 01/02/2023.
//

import UIKit

class HomeViewController: UICollectionViewController {
    
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
        
        createSnapshot()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex,_) -> NSCollectionLayoutSection? in
            guard let self = self,
                  let section = self.dataSource.sectionIdentifier(for: sectionIndex) else {
                return nil
            }
            
            switch section {
            case .category:
                let dimension = NSCollectionLayoutDimension.absolute(130)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: dimension,
                                                       heightDimension: .fractionalHeight(0.2))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
            }
        }
        
        return layout
    }
    
    private func createSnapshot() {
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
        dataSource.apply(snapshot)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let cell = sender as? UICollectionViewCell,
               let indexPath = self.collectionView.indexPath(for: cell),
               let item = dataSource.itemIdentifier(for: indexPath) {
                switch item {
                case .landmark(let landmark):
                    let vc = segue.destination as! DetailsViewController
                    vc.landmark = landmark
                }
            }
        }
    }
    
}

