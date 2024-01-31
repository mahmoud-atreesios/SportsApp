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
    
    var isLoading = BehaviorRelay<Bool>.init(value: false)

    func getAllLeagues(){
        isLoading.accept(true)
        ApiClient.shared().getData(modelDTO: LeagueModel.self, .getAllLeagues)
            .subscribe(onNext: { allLeagues in
                self.leagueDataModel = allLeagues
                self.leagueResult.accept(allLeagues.result)
                self.isLoading.accept(false)
            }, onError: { error in
                print("Error fetching latest fixtures: \(error)")
                self.isLoading.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    func getLatestFixetures(leagueID: String){
        isLoading.accept(true)
        ApiClient.shared().getData(modelDTO: LatestFixeturesModel.self, .getLatestFixetures(id: leagueID))
            .subscribe(onNext: { latestFixeturesPL in
                //print("Received latestFixetures: \(latestFixetures)")
                self.latestFixeturesModel = latestFixeturesPL
                self.latestFixeturesResult.accept(latestFixeturesPL.result)
                self.isLoading.accept(false)
            }, onError: { error in
                print("Error fetching latest fixtures: \(error)")
                self.isLoading.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    func getUpcomingFixetures(leagueID: String, from: String, to: String){
        isLoading.accept(true)
        ApiClient.shared().getData(modelDTO: UpcomingFixeturesModel.self, .getUpcomingFixetures(id: leagueID, from: from, to: to))
            .subscribe(onNext: { upcomingFixetures in
                self.upcomingFixeturesModell = upcomingFixetures
                self.upcomingFixeturesResult.accept(upcomingFixetures.result)
                self.isLoading.accept(false)
            }, onError: { error in
                print("Error fetching latest fixtures: \(error)")
                self.isLoading.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    func clearUpcomingFixtures() {
        self.upcomingFixeturesResult.accept([])
    }
    
}
