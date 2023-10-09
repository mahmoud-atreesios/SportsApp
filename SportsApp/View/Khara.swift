//
//  HomeVCC.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 09/10/2023.


import UIKit
import RxSwift
import RxCocoa
import RxRelay
import SDWebImage

class Khara: UIViewController {


    @IBOutlet weak var leagueCollectionView: UICollectionView!
    
    private let disposeBag = DisposeBag()
    var viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        leagueCollectionView.register(UINib(nibName: "LeagueCollectionCell", bundle: nil), forCellWithReuseIdentifier: "mycell")
        // Do any additional setup after loading the view.
        viewModel.getAllLeagues()
        bindLeagueCollectionViewToViewModel()
    }

    func bindLeagueCollectionViewToViewModel(){
        viewModel.leagueResult
            .bind (to: leagueCollectionView.rx.items(cellIdentifier: "mycell", cellType: LeagueCollectionCell.self))
        { int,result,cell  in
            cell.leagueImageView.sd_setImage(with: URL(string: result.leagueLogo ?? "CL"))
        }
    }

}
