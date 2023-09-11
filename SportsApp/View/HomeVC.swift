//
//  ViewController.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 11/09/2023.
//

import UIKit

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var leagueCollectionView: UICollectionView!
    @IBOutlet weak var LiveMatchCollectionView: UICollectionView!
    
    var arr = ["CL","laliga","PL","CL","laliga","PL","CL","laliga","PL","CL","laliga","PL","CL","laliga","PL","CL","laliga","PL","CL","laliga","PL","CL","laliga","PL"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        leagueCollectionView.delegate = self
        leagueCollectionView.dataSource = self
        
        LiveMatchCollectionView.delegate = self
        LiveMatchCollectionView.dataSource = self
        
        leagueCollectionView.register(UINib(nibName: "LeagueCollectionCell", bundle: nil), forCellWithReuseIdentifier: "mycell")
        LiveMatchCollectionView.register(UINib(nibName: "LiveMatchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "liveMatchCell")
        
    }
    
}

extension HomeVC{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.leagueCollectionView{
            return arr.count
        }else {
            return arr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.LiveMatchCollectionView{
            let maskPath = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topRight, .bottomLeft],
                                        cornerRadii: CGSize(width: 100,height: 100))
            let shape = CAShapeLayer()
            shape.path = maskPath.cgPath
            cell.layer.mask = shape
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.leagueCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! LeagueCollectionCell
            cell.layer.cornerRadius = 35.8
            cell.clipsToBounds = true
            cell.leagueImageView.image = UIImage(named: arr[indexPath.row])?.withRenderingMode(.alwaysTemplate)
            cell.leagueImageView.tintColor = UIColor(red: 33/255, green: 53/255, blue: 85/255, alpha: 1)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "liveMatchCell", for: indexPath) as! LiveMatchCollectionViewCell
            cell.backgroundImageView.image = UIImage(named: arr[indexPath.row])?.withRenderingMode(.alwaysTemplate)
            cell.backgroundImageView.tintColor = UIColor(red: 158/255, green: 159/255, blue: 165/255, alpha: 1)
            return cell
        }
    }
}


