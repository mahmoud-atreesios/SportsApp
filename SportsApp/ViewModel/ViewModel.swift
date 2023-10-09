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
    
    var leagueResult = PublishRelay<[Result]>.init()
    var latestFixeturesResult = PublishRelay<[latestFixetures]>.init()
    
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
    
    func getLatestFixetures(){
        ApiClient.shared().getData(modelDTO: LatestFixeturesModel.self, .getLatestFixetures)
            .subscribe(onNext: { latestFixetures in
                //print("Received latestFixetures: \(latestFixetures)")
                self.latestFixeturesModel = latestFixetures
                self.latestFixeturesResult.accept(latestFixetures.result)
            }, onError: { error in
                print("Error fetching latest fixtures: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
