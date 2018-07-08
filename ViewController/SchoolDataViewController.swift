//
//  SchoolDataViewController.swift
//  CodableDemoProject
//
//  Created by Dipak on 31/05/18.
//  Copyright © 2018 Dipak. All rights reserved.
//

import UIKit

class SchoolDataViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var schools : [School]?
    var schoolImage : UIImage?
    let imageCache = NSCache<NSString, UIImage>()

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var schoolDataTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "School data"
        self.navigationController?.navigationItem.hidesBackButton = true
        getSchoolsData()
        downloadImage()
    }

    
    // MARK: -  UItableView delegate & data sorce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRow = schools?.count ?? 0
        self.errorLabel.isHidden = numberOfRow == 0 ? false : true
        return numberOfRow;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolDataTableCell", for: indexPath) as! SchoolDataTableCell
        cell.selectionStyle = .none
        
        let schoolModel = schools![indexPath.row]
        
        cell.schoolCodeLabel.text = schoolModel.schoolCode
        cell.schoolURLLabel.text = schoolModel.url
        cell.schoolImageView.image = self.schoolImage
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Download Image from url and save in NSCache. If image is already downloaded fetch from NSCache.
    
    func downloadImage() {
       
        let imgUrl = "https://picsum.photos/200/300?image=0"
        if let cachedImage = self.imageCache.object(forKey: imgUrl as NSString) {
            print("Get Image from NSCache")
            schoolImage = cachedImage;
        } else {
            RestClient.getDataFromUrl(url: imgUrl) { (response) in
                
                switch response {
                case .success(let imageData):
                    
                    if let image = UIImage(data: imageData as! Data) {
                        self.schoolImage = image;
                        DispatchQueue.main.async() {
                            self.schoolDataTable.reloadData()
                        }
                        self.imageCache.setObject(image, forKey:imgUrl as NSString)
                    } else {
                        print("Image data is blank")
                    }
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
                
            }
        }
    }
    
    
    func getSchoolsData() {
        schools = getSchoolsRecordFromDisk()
        if schools != nil {
            print("Fetched records from disk")
            self.schoolDataTable.reloadData()
        } else {
            let url = "http://edunext.biz/getalldetails"
            RestClient.getSchoolsData(url: url) { (response) in
                print("response:\(response)")
                switch response {
                case .success(let schools):
                    self.schools = schools
                    self.saveSchoolsRecordToDisk(schools: self.schools)
                    print("Get Records from api call: \(String(describing: self.schools))")
                    DispatchQueue.main.async() {
                        self.schoolDataTable.reloadData()
                    }
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            }
            
        }
    }
    
    // Get a URL to the user's documents directory
    func getDocumentsURL() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Could not retrieve documents directory")
        }
    }
    
    
    func saveSchoolsRecordToDisk(schools: [School]?) {
        
        guard schools != nil else {
            print("Can not save record on disk because schools record is not available")
            return
        }
    
        // 1. Create a URL for documents-directory/schools.json
        let url = getDocumentsURL().appendingPathComponent("schools.json")
        // 2. Endcode our [School] data to JSON Data
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(schools)
            // 3. Write this data to the url specified in step 1
            try data.write(to: url, options: [])
        } catch {
            print("error:\(error.localizedDescription)")
        }
    }
    
    func getSchoolsRecordFromDisk() -> [School]? {
        // 1. Create a url for documents-directory/schools.json
        let url = getDocumentsURL().appendingPathComponent("schools.json")
        let decoder = JSONDecoder()
        do {
            // 2. Retrieve the data on the file in this path (if there is any)
            let data = try Data(contentsOf: url, options: [])
            // 3. Decode an array of Schools from this Data
            let schools = try decoder.decode([School].self, from: data)
            return schools
        } catch {
            print("error:\(error.localizedDescription)")
            return nil
        }
    }

}


