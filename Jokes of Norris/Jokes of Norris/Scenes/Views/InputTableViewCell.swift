//
//  InputTableViewCell.swift
//  Jokes of Norris
//
//  Created by Bruno Vinicius on 27/09/20.
//

import UIKit

protocol SearchTermDelegate {
    func searchTerm(term: String)
    func showMessageErro(message: String)
}

class InputTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    var delegate: SearchTermDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupTextField() {
        textField.delegate = self
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.darkGray.cgColor
        textField.layer.addSublayer(bottomLine)
        
        
    }

}

extension InputTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.count == 0 {
            delegate.showMessageErro(message: "Enter valid term to search")
        } else {
            textField.resignFirstResponder()
            delegate.searchTerm(term: textField.text!)
        }
        return true
    }
}
