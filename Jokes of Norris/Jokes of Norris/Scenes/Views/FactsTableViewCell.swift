//
//  FactsTableViewCell.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 27/09/20.
//

import UIKit

protocol ShareFactDelegate {
    func shareFact(fact: Fact)
}

class FactsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var constrainrHeightLabel: NSLayoutConstraint!
    @IBOutlet weak var constrainrWidthLabel: NSLayoutConstraint!
    
    var fact: Fact!
    var delegate: ShareFactDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupView() {
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        factLabel.text = fact.value
        factLabel.font = fact.value.count <= 80 ? factLabel.font.withSize(22) : factLabel.font.withSize(17)
        categoryLabel.text = fact.categories.count == 0 ? "UNCATEGORIZED" : fact.categories.first?.uppercased()
        constrainrHeightLabel.constant = categoryLabel.intrinsicContentSize.height+10
        constrainrWidthLabel.constant = categoryLabel.intrinsicContentSize.width+16
        categoryLabel.layer.cornerRadius = 6
        categoryLabel.clipsToBounds = true
    }
    
    @IBAction func shareAction(_ sender: Any) {
        delegate.shareFact(fact: fact)
    }
    
}
