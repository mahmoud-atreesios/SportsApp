//
//  LiveMatchCollectionViewCell.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 11/09/2023.
//

import UIKit

class LiveMatchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var matchTimeLabel: PaddingLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpMatchLabelUI()
    }
}

extension LiveMatchCollectionViewCell{
    func setUpMatchLabelUI(){
        matchTimeLabel.layer.borderColor = UIColor(red: 199/255, green: 0/255, blue: 57/255, alpha: 1).cgColor
        matchTimeLabel.layer.borderWidth = 2
        matchTimeLabel.layer.cornerRadius = 10

        matchTimeLabel.layer.shadowColor = UIColor(red: 199/255, green: 0/255, blue: 57/255, alpha: 1).cgColor // Set the shadow color to red
        matchTimeLabel.layer.shadowOffset = CGSize.zero // Set the shadow offset to zero
        matchTimeLabel.layer.shadowRadius = 10.0 // Set the shadow radius
        matchTimeLabel.layer.shadowOpacity = 0.8 // Set the shadow opacity
        matchTimeLabel.layer.masksToBounds = false
    }
}
