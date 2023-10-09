//
//  ViewController.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 11/09/2023.
//

import UIKit
import RxSwift
import RxCocoa

class HomeVC: UIViewController{
    
    @IBOutlet weak var leagueCollectionView: UICollectionView!
    @IBOutlet weak var LiveMatchCollectionView: UICollectionView!
    @IBOutlet weak var upComingMatchesTableView: UITableView!
    
    var arr = ["PL","laliga","CL"]
    
    private let disposeBag = DisposeBag()
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel.getAllLeagues()
        //bindLeagueCollectionToViewModel()
        teststh()
        
        viewModel.getLatestFixetures()
        bindLiveMatchCollectionToViewModel()
        
        upComingMatchesTableView.delegate = self
        upComingMatchesTableView.dataSource = self
        
        leagueCollectionView.register(UINib(nibName: "LeagueCollectionCell", bundle: nil), forCellWithReuseIdentifier: "mycell")
        LiveMatchCollectionView.register(UINib(nibName: "LiveMatchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "liveMatchCell")
        upComingMatchesTableView.register(UINib(nibName: "UpComingMatchesTableViewCell", bundle: nil), forCellReuseIdentifier: "upcomingCell")
    }
    
}

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

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()  // Can be an empty UIView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell", for: indexPath) as! UpComingMatchesTableViewCell
        DispatchQueue.main.async {
            cell.roundCorners([.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 20)
        }
        cell.layer.borderColor = UIColor(ciColor: .white).cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension HomeVC{
    
    func teststh(){
        Observable.just(arr)
            .bind(to: leagueCollectionView.rx.items(cellIdentifier: "mycell", cellType: LeagueCollectionCell.self)) { row, image, cell in
                cell.layer.cornerRadius = 35.8
                cell.clipsToBounds = true
                cell.leagueImageView.tintColor = UIColor(red: 33/255, green: 53/255, blue: 85/255, alpha: 1)
                cell.leagueImageView.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
            }
            .disposed(by: disposeBag)
    }
    
    func bindLiveMatchCollectionToViewModel(){
        viewModel.latestFixeturesResult
            .bind(to: LiveMatchCollectionView.rx.items(cellIdentifier: "liveMatchCell", cellType: LiveMatchCollectionViewCell.self)) { index, result, cell in
                
                cell.homeTeamLogo.sd_setImage(with: URL(string: result.homeTeamLogo))
                if let homeTeamName = result.eventHomeTeam {
                    let truncatedHomeTeamName = String(homeTeamName.prefix(3))
                    cell.homeTeamName.text = truncatedHomeTeamName
                }
                
                cell.awayTeamLogo.sd_setImage(with: URL(string: result.awayTeamLogo))
                if let awayTeamName = result.eventAwayTeam {
                    let truncatedAwayTeamName = String(awayTeamName.prefix(3))
                    cell.awayTeamName.text = truncatedAwayTeamName
                }
                cell.finalResult.text = result.eventFinalResult
                
                if let backgroundImage = UIImage(named: "laliga") {
                    let tintedImage = backgroundImage.withRenderingMode(.alwaysTemplate)
                    cell.backgroundImageView.image = tintedImage
                }
                
                cell.leagueName.text = result.leagueName
                cell.roundNumber.text = result.leagueRound
                cell.matchTimeLabel.text = result.eventTime
                
                cell.backgroundImageView.tintColor = UIColor(red: 158/255, green: 159/255, blue: 165/255, alpha: 1)
                DispatchQueue.main.async {
                    // cell.straightCutCorners([.topRight,.bottomLeft], cutLength: 50)
                    cell.roundCorners([.bottomLeft,.topRight], radius: 100)
                }
            }
            .disposed(by: disposeBag)
    }
}

