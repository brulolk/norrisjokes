//
//  CtagoryCollectionViewCell.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 27/09/20.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoriyLabel: UILabel!
    
    @IBOutlet weak var constrainrHeightLabel: NSLayoutConstraint!
    @IBOutlet weak var constrainrWidthLabel: NSLayoutConstraint!
    
    func setupCategory(category: String) {
        categoriyLabel.text = category.uppercased()
        constrainrHeightLabel.constant = categoriyLabel.intrinsicContentSize.height+10
        constrainrWidthLabel.constant = categoriyLabel.intrinsicContentSize.width+16
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
    }
    
}
