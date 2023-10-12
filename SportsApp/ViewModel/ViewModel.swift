//
//  ViewModel.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 02/10/2023.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel{
    
    private let disposeBag = DisposeBag()
    
    var leagueDataModel: LeagueModel?
    var latestFixeturesModel: LatestFixeturesModel?
    var upcomingFixeturesModell: UpcomingFixeturesModel?
    
    var leagueResult = PublishRelay<[Result]>.init()
    var latestFixeturesResult = PublishRelay<[latestFixetures]>.init()
    var upcomingFixeturesResult = BehaviorRelay<[UpcomingFixetures]>.init(value: [])

    
    func getAllLeagues(){
        ApiClient.shared().getData(modelDTO: LeagueModel.self, .getAllLeagues)
            .subscribe(onNext: { allLeagues in
                self.leagueDataModel = allLeagues
                self.leagueResult.accept(allLeagues.result)
            }, onError: { error in
                print("Error fetching latest fixtures: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    func getLatestFixetures(leagueID: String){
        ApiClient.shared().getData(modelDTO: LatestFixeturesModel.self, .getLatestFixetures(id: leagueID))
            .subscribe(onNext: { latestFixeturesPL in
                //print("Received latestFixetures: \(latestFixetures)")
                self.latestFixeturesModel = latestFixeturesPL
                self.latestFixeturesResult.accept(latestFixeturesPL.result)
            }, onError: { error in
                print("Error fetching latest fixtures: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    func getUpcomingFixetures(leagueID: String){
        ApiClient.shared().getData(modelDTO: UpcomingFixeturesModel.self, .getUpcomingFixetures(id: leagueID))
            .subscribe(onNext: { upcomingFixetures in
                self.upcomingFixeturesModell = upcomingFixetures
                self.upcomingFixeturesResult.accept(upcomingFixetures.result)
            }, onError: { error in
                print("Error fetching latest fixtures: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    func clearUpcomingFixtures() {
        self.upcomingFixeturesResult.accept([])
    }
    
}
