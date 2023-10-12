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
    
    var arr = ["PL","laliga","EPL2","BL","CL","SA"]
    
    var dic = ["PL":"152" , "laliga":"302", "EPL2":"141", "SA":"207", "BL":"175"]
    
    private let disposeBag = DisposeBag()
    var viewModel = ViewModel()
    
    var leagueID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        leagueCollectionView.register(UINib(nibName: "LeagueCollectionCell", bundle: nil), forCellWithReuseIdentifier: "mycell")
        LiveMatchCollectionView.register(UINib(nibName: "LiveMatchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "liveMatchCell")
        upComingMatchesTableView.register(UINib(nibName: "UpComingMatchesTableViewCell", bundle: nil), forCellReuseIdentifier: "upcomingCell")
        
        setupCollectionView()
        
        bindLiveMatchCollectionToViewModel()
        
        bindUpcomingTableViewtoViewModel()
        
        self.viewModel.getLatestFixetures(leagueID: self.dic["PL"]!)
        self.viewModel.getUpcomingFixetures(leagueID: self.dic["PL"]!)
    }
    
}

extension HomeVC{
    
    func setupCollectionView(){
        
        var selectedCell: LeagueCollectionCell?
        
        print("Array count: \(arr.count)")
        
        Observable.just(arr)
            .bind(to: leagueCollectionView.rx.items(cellIdentifier: "mycell", cellType: LeagueCollectionCell.self)) { row, image, cell in
                cell.layer.cornerRadius = 35.8
                cell.clipsToBounds = true
                cell.leagueImageView.tintColor = UIColor(red: 33/255, green: 53/255, blue: 85/255, alpha: 1)
                cell.leagueImageView.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
                
                // Handle cell selection
                let tapGesture = UITapGestureRecognizer()
                cell.leagueImageView.addGestureRecognizer(tapGesture)
                cell.leagueImageView.isUserInteractionEnabled = true
                
                tapGesture.rx.event
                    .subscribe(onNext: { _ in

                        if let selected = selectedCell {
                            selected.backgroundColor = UIColor(red: 216/255, green: 217/255, blue: 218/255, alpha: 1.0)
                        }
                        
                        selectedCell = cell
                        cell.backgroundColor = UIColor(red: 180/255, green: 180/255, blue: 179/255, alpha: 1.0)

                        if row == 0 {
                            // 3aezo lma edos hna eb3at ll api l id bta3 l league w egyb l data w b kda hakon mstakhdm function wa7da w model wa7da bs
                            print("First row selected!")
                            self.leagueID = self.dic["PL"]

                        }else if row == 1{
                            print("Second row selected!")
                            self.leagueID = self.dic["laliga"]

                        }else if row == 2{
                            print("third row selected!")
                            self.leagueID = self.dic["EPL2"]

                        }else if row == 3{
                            print("fourth row selected!")
                            self.leagueID = self.dic["BL"]

                        }else if row == 5{
                            print("fourth row selected!")
                            self.leagueID = self.dic["SA"]

                        }
                        
                        self.viewModel.clearUpcomingFixtures()
                        self.viewModel.getLatestFixetures(leagueID: self.leagueID!)
                        self.viewModel.getUpcomingFixetures(leagueID: self.leagueID!)
                    })
                    .disposed(by: self.disposeBag)
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
                
                // Check if the league ID matches the selected league
                if self.leagueID == self.dic["PL"] {
                    if let backgroundImage = UIImage(named: "PL") {
                        let tintedImage = backgroundImage.withRenderingMode(.alwaysTemplate)
                        cell.backgroundImageView.image = tintedImage
                    }
                } else if self.leagueID == self.dic["laliga"] {
                    if let backgroundImage = UIImage(named: "laliga") {
                        let tintedImage = backgroundImage.withRenderingMode(.alwaysTemplate)
                        cell.backgroundImageView.image = tintedImage
                    }
                } else if self.leagueID == self.dic["EPL2"] {
                    if let backgroundImage = UIImage(named: "EPL2") {
                        let tintedImage = backgroundImage.withRenderingMode(.alwaysTemplate)
                        cell.backgroundImageView.image = tintedImage
                    }
                } else if self.leagueID == self.dic["BL"] {
                    if let backgroundImage = UIImage(named: "BL") {
                        let tintedImage = backgroundImage.withRenderingMode(.alwaysTemplate)
                        cell.backgroundImageView.image = tintedImage
                    }
                } else if self.leagueID == self.dic["SA"] {
                    if let backgroundImage = UIImage(named: "SA") {
                        let tintedImage = backgroundImage.withRenderingMode(.alwaysTemplate)
                        cell.backgroundImageView.image = tintedImage
                    }
                }
                
                cell.leagueName.text = result.leagueName
                cell.roundNumber.text = result.leagueRound
                cell.matchTimeLabel.text = result.eventStatus
                cell.backgroundImageView.tintColor = UIColor(red: 180/255, green: 180/255, blue: 179/255, alpha: 1)
                
                DispatchQueue.main.async {
                    // cell.straightCutCorners([.topRight,.bottomLeft], cutLength: 50)
                    cell.roundCorners([.bottomLeft,.topRight], radius: 100)
                }
            }
            .disposed(by: disposeBag)
    }
    
}

extension HomeVC{
    
    func bindUpcomingTableViewtoViewModel(){

        viewModel.upcomingFixeturesResult
            .subscribe(onNext: { [weak self] fixtures in
                guard let self = self else { return }

                if fixtures.isEmpty {
                    let noMatchesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.upComingMatchesTableView.bounds.size.width, height: self.upComingMatchesTableView.bounds.size.height))
                    noMatchesLabel.text = "No matches for today"
                    noMatchesLabel.textColor = UIColor.gray
                    noMatchesLabel.textAlignment = .center

                    self.upComingMatchesTableView.backgroundView = noMatchesLabel
                    self.upComingMatchesTableView.separatorStyle = .none
                } else {
                    DispatchQueue.main.async {
                        self.upComingMatchesTableView.backgroundView = nil
                        self.upComingMatchesTableView.separatorStyle = .singleLine
                    }
                }
            })
            .disposed(by: disposeBag)

        viewModel.upcomingFixeturesResult
            .bind(to: upComingMatchesTableView.rx.items) { tableView, row, element in
                // Configure your cell using 'element' which represents an upcoming fixture
                let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell", for: IndexPath(row: row, section: 0)) as! UpComingMatchesTableViewCell
                cell.homeTeamLogo.sd_setImage(with: URL(string: element.homeTeamLogo))
                cell.homeTeamName.text = element.eventHomeTeam

                cell.awayTeamLogo.sd_setImage(with: URL(string: element.awayTeamLogo))
                cell.awayTeamName.text = element.eventAwayTeam

                cell.matchDate.text = element.eventDate
                cell.matchTime.text = element.eventTime

                DispatchQueue.main.async {
                    cell.roundCorners([.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 20)
                }
                cell.layer.borderColor = UIColor(ciColor: .white).cgColor
                cell.layer.borderWidth = 1

                return cell
            }
            .disposed(by: disposeBag)

    }
    
}
