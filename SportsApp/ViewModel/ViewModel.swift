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
    var LALIGA: LatestFixeturesModel?
    
    var leagueResult = PublishRelay<[Result]>.init()
    var latestFixeturesResult = PublishRelay<[latestFixetures]>.init()
    var LALIGAResult = PublishRelay<[latestFixetures]>.init()

    
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
    
    func getLatestFixeturesPL(leagueID: String){
        ApiClient.shared().getData(modelDTO: LatestFixeturesModel.self, .getPLFixetures(id: leagueID))
            .subscribe(onNext: { latestFixeturesPL in
                //print("Received latestFixetures: \(latestFixetures)")
                self.latestFixeturesModel = latestFixeturesPL
                self.latestFixeturesResult.accept(latestFixeturesPL.result)
            }, onError: { error in
                print("Error fetching latest fixtures: \(error)")
            })
            .disposed(by: disposeBag)
    }
    
    func getLatestFixeturesLALIGA(){
        ApiClient.shared().getData(modelDTO: LatestFixeturesModel.self, .getLALIGAFixetures)
            .subscribe(onNext: { latestFixeturesLALIGA in
                //print("Received latestFixetures: \(latestFixetures)")
                self.LALIGA = latestFixeturesLALIGA
                self.LALIGAResult.accept(latestFixeturesLALIGA.result)
            }, onError: { error in
                print("Error fetching latest fixtures: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
