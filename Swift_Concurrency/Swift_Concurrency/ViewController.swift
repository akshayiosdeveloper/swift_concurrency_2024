//
//  ViewController.swift
//  Swift_Concurrency
//
//  Created by Akshay Kumar on 09/04/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()  {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task {
            await self.getResult()
        }
    }

    func getResult() async  {
        let day1 = Day1()
        let result = await day1.randowmD7()
        print(result)
    }
}

