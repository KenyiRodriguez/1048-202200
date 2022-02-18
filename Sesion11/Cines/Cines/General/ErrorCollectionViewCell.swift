//
//  ErrorTableViewCell.swift
//  Cines
//
//  Created by Kenyi Rodriguez on 11/02/22.
//

import UIKit

class ErrorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var lblErrorMessage: UILabel!
    @IBOutlet private weak var anchorWidth: NSLayoutConstraint!
    @IBOutlet private weak var anchorHeight: NSLayoutConstraint!
    
    func updateSize(_ size: CGSize) {
        self.anchorWidth.constant = size.width
        self.anchorHeight.constant = size.height
    }
    
    func updateData(_ errorMessage: String) {
        self.lblErrorMessage.text = errorMessage
    }
}

extension ErrorCollectionViewCell {

    class func buildIn(_ collectionView: UICollectionView, indexPath: IndexPath, errorMessage: String) -> ErrorCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ErrorCollectionViewCell", for: indexPath) as? ErrorCollectionViewCell
        cell?.updateData(errorMessage)
        return cell ?? ErrorCollectionViewCell()
    }
}

