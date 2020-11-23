//
//  ViewController.swift
//  Api+Moya
//
//  Created by HongNhan on 11/23/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var getDataButton: UIButton!
    
    let provider = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getDataButtonDidTap(_ sender: Any) {
        provider.getNewMovies(page: 1) { movies in
        }
    }
    
    @IBAction func getDetailButtonDidTap(_ sender: Any) {
        provider.getDetailMovie(id: 671039) { movie in
        }
    }
}

