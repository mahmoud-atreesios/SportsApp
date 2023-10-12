//
//  Constants.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 02/10/2023.
//

import Foundation

struct Constants{
    enum links{
        static let apikey = "b14f778e8d8380eb1bf49d44af1e3f4bca4743eefbc5516ef32f9574bb3ebfa2"
        
        static let leagueUrl = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey="
        
        static let latestFixteuresURL = "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey="
        static let leagueId = "&from=2023-10-8&to=2023-10-8&leagueId="
        
        static let leagueIdd = "&from=2023-10-21&to=2023-10-21&leagueId="
        
        static let fixeturesLALIGA = "&from=2023-10-8&to=2023-10-8&leagueId=302"
        static let fixeturesPL = "&from=2023-10-8&to=2023-10-8&leagueId=152"
    }
}
