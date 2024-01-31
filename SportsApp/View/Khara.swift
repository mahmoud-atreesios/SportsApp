//
//  HomeVCC.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 09/10/2023.


import UIKit
import CTPanoramaView

class Khara: UIViewController{
    
    @IBOutlet weak var panoramaView: CTPanoramaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "spherical.jpg")
        panoramaView.image = image
        panoramaView.controlMethod = .both
    }
}

