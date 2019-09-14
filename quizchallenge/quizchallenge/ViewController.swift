//
//  ViewController.swift
//  quizchallenge
//
//  Created by alessandra.l.pereira on 13/09/19.
//  Copyright © 2019 alnp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var networkManager: NetworkManager!

    init(networkManager: NetworkManager) {
        super.init(nibName: nil, bundle: nil)
        self.networkManager = networkManager
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            view.backgroundColor = .green
            networkManager.getQuiz(number: 1) { result in
                switch result {
                case .success(let response):
                    print(response.question)
                    print(response.answer)
                case .failure(let error):
                    print(error)
                }


        }
    }


}

