//
//  GenreViewController.swift
//  MyFlixDB
//
//  Created by Blake Oistad on 2/21/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController {

    //MARK: - Properties
    var selectedGenre: String?
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedGenre
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
