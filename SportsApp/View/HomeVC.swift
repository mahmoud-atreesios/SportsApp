//
//  ViewController.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 11/09/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SDWebImage

class HomeVC: UIViewController{
    
    @IBOutlet weak var leagueCollectionView: UICollectionView!
    @IBOutlet weak var LiveMatchCollectionView: UICollectionView!
    @IBOutlet weak var upComingMatchesTableView: UITableView!
    
    var arr = ["PL","laliga","EPL2","BL","CL","SA"]
    
    var dic = ["PL":"152" , "laliga":"302", "EPL2":"141", "SA":"207", "BL":"175"]
    
    private let disposeBag = DisposeBag()
    var viewModel = ViewModel()
    
    var leagueID: String?
    var loader: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        leagueCollectionView.register(UINib(nibName: "LeagueCollectionCell", bundle: nil), forCellWithReuseIdentifier: "mycell")
        LiveMatchCollectionView.register(UINib(nibName: "LiveMatchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "liveMatchCell")
        upComingMatchesTableView.register(UINib(nibName: "UpComingMatchesTableViewCell", bundle: nil), forCellReuseIdentifier: "upcomingCell")
        
        setupCollectionView()
        bindLiveMatchCollectionToViewModel()
        bindUpcomingTableViewtoViewModel()
        
        upComingMatchesTableView.delegate = self
        
        
        self.viewModel.getLatestFixetures(leagueID: self.dic["PL"]!)
        self.viewModel.getUpcomingFixetures(leagueID: self.dic["PL"]!, from: calculateFormattedLaunchDate(), to: getFormattedDateAfterTenDays())
    }
    
}

// MARK: Binding View to ViewModel
extension HomeVC{
    
    
    func setupCollectionView(){
        
        var selectedCell: LeagueCollectionCell?
        var hasExecutedOnce = false

        print("Array count: \(arr.count)")
        
        Observable.just(arr)
            .bind(to: leagueCollectionView.rx.items(cellIdentifier: "mycell", cellType: LeagueCollectionCell.self)) { row, image, cell in
                cell.layer.cornerRadius = 35.8
                cell.clipsToBounds = true
                cell.leagueImageView.tintColor = UIColor(red: 33/255, green: 53/255, blue: 85/255, alpha: 1)
                cell.leagueImageView.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
                
                
                // Execute this block only once
                if !hasExecutedOnce {
                    // Set background color for the first row by default
                    if row == 0 {
                        cell.backgroundColor = UIColor(red: 180/255, green: 180/255, blue: 179/255, alpha: 1.0)
                        selectedCell = cell
                        //self.leagueID = self.dic["PL"] // Assuming arr contains the keys
                    }
                    hasExecutedOnce = true
                }
                
                // Handle cell selection
                let tapGesture = UITapGestureRecognizer()
                cell.leagueImageView.addGestureRecognizer(tapGesture)
                cell.leagueImageView.isUserInteractionEnabled = true
                
                tapGesture.rx.event
                    .subscribe(onNext: { [self] _ in

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
                        self.viewModel.getUpcomingFixetures(leagueID: self.leagueID!, from: calculateFormattedLaunchDate(), to: getFormattedDateAfterTenDays())
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
                
                let backgroundImage = UIImage(named: "PL")
                let tintedImage = backgroundImage!.withRenderingMode(.alwaysTemplate)
                cell.backgroundImageView.image = tintedImage
                
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
    
    func bindUpcomingTableViewtoViewModel() {
        viewModel.upcomingFixeturesResult
            .subscribe(onNext: { [weak self] fixtures in
                guard let self = self else { return }

                if fixtures.isEmpty {
                    self.setUpLoader()

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
            .map { fixtures in
                // Group fixtures by eventDate
                Dictionary(grouping: fixtures, by: { $0.eventDate })
            }
            .map { dictionary in
                // Sort the keys (event dates) in ascending order
                let sortedKeys = dictionary.keys.sorted { $0 < $1 }

                return sortedKeys.map { key in
                    guard let value = dictionary[key] else { return SectionModel(model: "", items: []) }
                    return SectionModel(model: key, items: value)
                }
            }
            .bind(to: upComingMatchesTableView.rx.items(dataSource: createDataSource()))
            .disposed(by: disposeBag)
    }

    private func createDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, UpcomingFixetures>> {
        return RxTableViewSectionedReloadDataSource<SectionModel<String, UpcomingFixetures>>(
            configureCell: { (_, tableView, indexPath, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell", for: indexPath) as! UpComingMatchesTableViewCell
                // Configure the cell using element (fixture)
                cell.homeTeamLogo.sd_setImage(with: URL(string: element.homeTeamLogo))
                cell.homeTeamName.text = element.eventHomeTeam

                cell.awayTeamLogo.sd_setImage(with: URL(string: element.awayTeamLogo))
                cell.awayTeamName.text = element.eventAwayTeam

                cell.matchDate.text = element.eventDate
                cell.matchTime.text = element.eventTime

                cell.roundCorners([.topLeft,.topRight,.bottomLeft,.bottomRight], radius: 20)
                cell.layer.borderColor = UIColor(ciColor: .white).cgColor
                cell.layer.borderWidth = 1

                return cell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
            }
        )
    }

}

extension HomeVC: UITableViewDelegate{
    
}

// MARK: setup Loader
extension HomeVC{
    func setUpLoader(){
        loader = UIActivityIndicatorView(style: .large)
        loader.center = CGPoint(x: 180, y: 200)
        view.addSubview(loader)
        
        viewModel.isLoading
            .asObservable()
            .subscribe(onNext: { [weak self] isLoading in
                DispatchQueue.main.async {
                    if isLoading {
                        self?.loader.startAnimating()
                    } else {
                        self?.loader.stopAnimating()
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    func calculateFormattedLaunchDate() -> String {
        guard let launchDate = UserDefaults.standard.value(forKey: "appLaunchDate") as? Date
        else {
            return ""
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: launchDate)
    }
    
    func getFormattedDateAfterTenDays() -> String {
        if let dateAfterTenDays = getDateAfterTenDays() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: dateAfterTenDays)
        } else {
            return ""
        }
    }

    func getDateAfterTenDays() -> Date? {
        
        let currentDate = Date()
        let calendar = Calendar.current

        if let dateAfterTenDays = calendar.date(byAdding: .day, value: 10, to: currentDate) {
            return dateAfterTenDays
        } else {
            return nil
        }
    }


}
