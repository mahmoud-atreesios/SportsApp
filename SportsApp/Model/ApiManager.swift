//
//  ApiManager.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 02/10/2023.
//

import Foundation

import Foundation
import RxSwift

protocol fetchData {
    func getData<T: Decodable>(modelDTO: T.Type, _ endpoint: Endpoints, attributes: [String: String]?) -> Observable<T>
}

enum Endpoints {
    case getAllLeagues
    case getLatestFixetures(id: String)
    case getUpcomingFixetures(id: String)
    
    var stringUrl: URL {
        switch self {
        case .getAllLeagues:
            return URL(string: Constants.links.leagueUrl + Constants.links.apikey)!
        case .getLatestFixetures(let id):
            return URL(string: Constants.links.latestFixteuresURL + Constants.links.apikey + Constants.links.leagueId + "\(id)")!
        case .getUpcomingFixetures(let id):
            return URL(string: Constants.links.latestFixteuresURL + Constants.links.apikey + Constants.links.leagueIdd + "\(id)")!
        }
    }
}

class ApiClient {
    private static let sharedInstance = ApiClient()

    static func shared() -> ApiClient {
        return ApiClient.sharedInstance
    }

    private init() {}

    func getData<T>(modelDTO: T.Type, _ endpoint: Endpoints) -> Observable<T> where T: Decodable {
        return Observable.create { observer in
            let task = URLSession.shared.dataTask(with: endpoint.stringUrl) { data, _, error in
                if let error = error {
                    observer.onError(error)
                } else if let data = data {
                    do {
                        let exchangeRate = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(exchangeRate)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
