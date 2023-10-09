//
//  LeagueDataModel.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 02/10/2023.
//
import Foundation

struct LeagueModel: Decodable {
    let success: Int
    let result: [Result]
}

struct Result: Codable {
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int
    let countryName: String
    let leagueLogo, countryLogo: String?

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
}
