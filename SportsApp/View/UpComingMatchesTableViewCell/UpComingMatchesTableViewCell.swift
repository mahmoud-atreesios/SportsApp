//
//  UpComingMatchesTableViewCell.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 14/09/2023.
//

import UIKit

class UpComingMatchesTableViewCell: UITableViewCell {

    @IBOutlet weak var homeTeamLogo: UIImageView!
    @IBOutlet weak var homeTeamName: UILabel!
    
    @IBOutlet weak var awayTeamLogo: UIImageView!
    @IBOutlet weak var awayTeamName: UILabel!
    
    
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var matchTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
