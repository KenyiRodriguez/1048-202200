//
//  ListMovieAdapter.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 21/02/22.
//

import UIKit

class ListMovieAdapter: NSObject {
    
    private unowned let controller: ListMoviesViewControllerProtocol
    var dataSource = [Any]()
    
    init(controller: ListMoviesViewControllerProtocol) {
        self.controller = controller
    }
    
    func setCollectionView(_ collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ListMovieAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let movie = self.dataSource[indexPath.row] as? Movie {
            return MovieCollectionViewCell.buildIn(collectionView, indexPath: indexPath, movie: movie)
            
        } else if let errorMessage = self.dataSource[indexPath.row] as? String {
            return ErrorCollectionViewCell.buildIn(collectionView, indexPath: indexPath, errorMessage: errorMessage)
            
        } else {
            return UICollectionViewCell()
        }
    }
}

extension ListMovieAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let movie = self.dataSource[indexPath.row] as? Movie {
            self.controller.goToMovieDetail(movie)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        if let cell = cell as? MovieCollectionViewCell {
            
            let numberOfColumns: CGFloat = 2
            let totalWidth = collectionView.frame.width
            let insets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
            let minSpaces = flowLayout.minimumInteritemSpacing * (numberOfColumns - 1)
            
            let availableWidth = totalWidth - insets - minSpaces
            let cellWidth = availableWidth / numberOfColumns
            
            cell.updateWidth(cellWidth.rounded(.down))
            
        } else if let cell = cell as? ErrorCollectionViewCell {
            
            var collectionSize = collectionView.frame.size
            collectionSize.width -= (flowLayout.sectionInset.left + flowLayout.sectionInset.right)
            collectionSize.height -= (flowLayout.sectionInset.top + flowLayout.sectionInset.bottom)
            
            cell.updateSize(collectionSize)
        }
    }
}
