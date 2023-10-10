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


//extension HomeVC:  UICollectionViewDelegate, UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == self.leagueCollectionView{
//            return arr.count
//        }else {
//            return arr.count
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == self.leagueCollectionView{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! LeagueCollectionCell
//            cell.layer.cornerRadius = 35.8
//            cell.clipsToBounds = true
//            cell.leagueImageView.image = UIImage(named: arr[indexPath.row])?.withRenderingMode(.alwaysTemplate)
//            cell.leagueImageView.tintColor = UIColor(red: 33/255, green: 53/255, blue: 85/255, alpha: 1)
//            return cell
//        }else{
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "liveMatchCell", for: indexPath) as! LiveMatchCollectionViewCell
//            cell.backgroundImageView.image = UIImage(named: arr[indexPath.row])?.withRenderingMode(.alwaysTemplate)
//            cell.backgroundImageView.tintColor = UIColor(red: 158/255, green: 159/255, blue: 165/255, alpha: 1)
//            DispatchQueue.main.async {
//               // cell.straightCutCorners([.topRight,.bottomLeft], cutLength: 50)
//                cell.roundCorners([.bottomLeft,.topRight], radius: 100)
//            }
//            return cell
//        }
//    }
//}
