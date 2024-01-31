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


//    func LALIGA(){
//        viewModel.LALIGAResult
//            .bind(to: LiveMatchCollectionView.rx.items(cellIdentifier: "liveMatchCell", cellType: LiveMatchCollectionViewCell.self)) { index, result, cell in
//
//                cell.homeTeamLogo.sd_setImage(with: URL(string: result.homeTeamLogo))
//                if let homeTeamName = result.eventHomeTeam {
//                    let truncatedHomeTeamName = String(homeTeamName.prefix(3))
//                    cell.homeTeamName.text = truncatedHomeTeamName
//                }
//
//                cell.awayTeamLogo.sd_setImage(with: URL(string: result.awayTeamLogo))
//                if let awayTeamName = result.eventAwayTeam {
//                    let truncatedAwayTeamName = String(awayTeamName.prefix(3))
//                    cell.awayTeamName.text = truncatedAwayTeamName
//                }
//                cell.finalResult.text = result.eventFinalResult
//
//                if let backgroundImage = UIImage(named: "laliga") {
//                    let tintedImage = backgroundImage.withRenderingMode(.alwaysTemplate)
//                    cell.backgroundImageView.image = tintedImage
//                }
//
//                cell.leagueName.text = result.leagueName
//                cell.roundNumber.text = result.leagueRound
//                cell.matchTimeLabel.text = result.eventTime
//
//                cell.backgroundImageView.tintColor = UIColor(red: 158/255, green: 159/255, blue: 165/255, alpha: 1)
//                DispatchQueue.main.async {
//                    // cell.straightCutCorners([.topRight,.bottomLeft], cutLength: 50)
//                    cell.roundCorners([.bottomLeft,.topRight], radius: 100)
//                }
//            }
//            .disposed(by: disposeBag)
//    }


//    func bindUpcomingTableViewtoViewModel(){
//
//        viewModel.upcomingFixeturesResult
//            .subscribe(onNext: { [weak self] fixtures in
//                guard let self = self else { return }
//
//                if fixtures.isEmpty {
//
//                    self.setUpLoader()
//
//                    let noMatchesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.upComingMatchesTableView.bounds.size.width, height: self.upComingMatchesTableView.bounds.size.height))
//                    noMatchesLabel.text = "No matches for today"
//                    noMatchesLabel.textColor = UIColor.gray
//                    noMatchesLabel.textAlignment = .center
//
//                    self.upComingMatchesTableView.backgroundView = noMatchesLabel
//                    self.upComingMatchesTableView.separatorStyle = .none
//                } else {
//                    DispatchQueue.main.async {
//                        self.upComingMatchesTableView.backgroundView = nil
//                        self.upComingMatchesTableView.separatorStyle = .singleLine
//                    }
//                }
//            })
//            .disposed(by: disposeBag)
//
//        viewModel.upcomingFixeturesResult
//            .bind(to: upComingMatchesTableView.rx.items) { tableView, row, element in
//                // Configure your cell using 'element' which represents an upcoming fixture
//                let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell", for: IndexPath(row: row, section: 0)) as! UpComingMatchesTableViewCell
//                cell.homeTeamLogo.sd_setImage(with: URL(string: element.homeTeamLogo))
//                cell.homeTeamName.text = element.eventHomeTeam
//
//                cell.awayTeamLogo.sd_setImage(with: URL(string: element.awayTeamLogo))
//                cell.awayTeamName.text = element.eventAwayTeam
//
//                cell.matchDate.text = element.eventDate
//                cell.matchTime.text = element.eventTime
//
//                DispatchQueue.main.async {
//                    cell.roundCorners([.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 20)
//                }
//                cell.layer.borderColor = UIColor(ciColor: .white).cgColor
//                cell.layer.borderWidth = 1
//
//                return cell
//            }
//            .disposed(by: disposeBag)
//    }


//        // Create a dispatch group
//        let group = DispatchGroup()
//
//        // Enter the dispatch group before starting each task
//        group.enter()
//        getFirstToken {
//            // Leave the dispatch group once the task is complete
//            group.leave()
//        }
//
//        group.enter()
//        getOrderId {
//            group.leave()
//        }
//
//        group.enter()
//        getPaymentToken {
//            group.leave()
//        }
//
//        // Notify when all tasks are completed
//        group.notify(queue: .main) {
//            // All tasks are completed, you can proceed with further actions here
//            // This will be executed after all three functions complete their tasks
//            print("All tasks completed")
//        }
