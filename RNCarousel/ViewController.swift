//
//  ViewController.swift
//  RNCarousel
//
//  Created by Nguyen Hoang on 6/18/19.
//  Copyright © 2019 fh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var carouView: CaroulselView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // init image url for carousel
        let itemImageUrl:[String] = ["https://media-public.canva.com/MADGwO3Bpao/5/screen_2x.jpg","https://media-public.canva.com/MADGv8CpMRg/6/screen_2x.jpg","https://media-public.canva.com/MADGwIcKyao/5/screen_2x.jpg","https://media-public.canva.com/MADGwNp4NH4/5/screen_2x.jpg",
                                     "https://media-public.canva.com/MADGx2YyCs4/4/screen_2x.jpg","https://media-public.canva.com/MADGwBBeKuE/5/screen_2x.jpg"
        ]
        carouView.setupData(imageURL: itemImageUrl)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
   
    }

}

