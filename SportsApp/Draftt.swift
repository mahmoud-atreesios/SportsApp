//
//  Draftt.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 09/10/2023.
//

import Foundation
//    func bindLeagueCollectionToViewModel() {
//        viewModel.leagueResult
//            .map { results in
//                // Filter out the results with a non-nil leagueLogo
//                return results.filter { $0.leagueLogo != nil }
//            }
//            .bind(to: leagueCollectionView.rx.items(cellIdentifier: "mycell", cellType: LeagueCollectionCell.self)) { index, result, cell in
//                cell.layer.cornerRadius = 35.8
//                cell.clipsToBounds = true
//                cell.leagueImageView.tintColor = UIColor(red: 33/255, green: 53/255, blue: 85/255, alpha: 1)
//
//                if let leagueLogo = result.leagueLogo {
//                    cell.leagueImageView.sd_setImage(with: URL(string: leagueLogo))
//                }
//            }
//            .disposed(by: disposeBag)
//    }
