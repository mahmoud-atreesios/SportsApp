//
//  Constants.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 02/10/2023.
//

import Foundation

struct Constants{
    enum links{
        static let apikey = "add9af391d6328e43143d1a31f2f3dff804a660e33afdb72223d14c254f121a4"
        
        static let leagueUrl = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey="
        
        static let latestFixteuresURL = "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey="
        static let leagueId = "&from=2023-12-30&to=2024-1-2&leagueId="
        
        static let leagueIdd = "&leagueId="
        
        static let fixeturesLALIGA = "&from=2023-10-8&to=2023-10-8&leagueId=302"
        static let fixeturesPL = "&from=2023-10-8&to=2023-10-8&leagueId=152"
        
        static let iframe = "https://accept.paymob.com/api/acceptance/iframes/794774?payment_token="
        
        
    }
}
