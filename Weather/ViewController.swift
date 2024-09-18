//
//  ViewController.swift
//  Weather
//
//  Created by Mac on 13/09/24.
//

import UIKit

class ViewController: UIViewController {
    
    private var apiCall = ApiCall()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        apiCall.getApiData()
    }


}

