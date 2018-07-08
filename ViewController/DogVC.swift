//
//  DogVC.swift
//  CodableDemoProject
//
//  Created by Dipak Pandey on 08/07/18.
//  Copyright © 2018 Intigate technologies pvt ltd. All rights reserved.
//

import UIKit

class DogVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dog: [String] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDogsData()
    }
    
    
    func getDogsData() {
            let url = "https://dog.ceo/api/breeds/list/all"
            RestClient.getDogsData(url: url) { (response) in
                switch response {
                case .success(let dogs):
                    self.dog = Array(dogs.message.keys)
                    print("Get Records from api call: \(String(describing: self.dog)))")
                    DispatchQueue.main.async() {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
}
    
    // MARK: -  UItableView delegate & data sorce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRow = dog.count
        return numberOfRow;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as! DogCell
                cell.name.text = dog[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}


