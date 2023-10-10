//
//  SecondVC.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 13/09/2023.
//

import UIKit

class SecondVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var testcollectionview: UICollectionView!
    
    var array = ["PL","laliga","CL","PL","laliga","CL","PL","laliga","CL","PL","laliga","CL","PL","laliga","CL"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testcollectionview.delegate = self
        testcollectionview.dataSource = self
        
        testcollectionview.register(UINib(nibName: "LeagueCollectionCell", bundle: nil), forCellWithReuseIdentifier: "mycell")
    }

    
    @IBAction func btn(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mycell", for: indexPath) as! LeagueCollectionCell
        return cell
    }
    
}
