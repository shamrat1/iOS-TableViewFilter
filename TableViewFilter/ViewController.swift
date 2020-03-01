//
//  ViewController.swift
//  TableViewFilter
//
//  Created by Yasin Shamrat on 1/3/20.
//  Copyright © 2020 Yasin Shamrat. All rights reserved.
//

import UIKit

enum selectedScope: Int {
    case all = 0
    case missing = 1
    case found = 2
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK:- Data and Outlets
//    let data = [["Someone"], "Anyone" , "Lucky One" , "A few lucky one", "Okay Everyone"]
    let data = [
        ["Habib","missing"],
        ["Anyone","missing"],
        ["Lucky One","found"],
        ["A few lucky one","found"],
        ["Okay Everyone","missing"]
    ]
    var dataForPlay: [[String]] = []
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dataForPlay = data
        setupSearchBar()
    }
    
    // MARK:- Searchbar Delegates
    
    // for setting up searchbar in table view
    func setupSearchBar(){
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width:(UIScreen.main.bounds.width), height: 70))
        searchBar.showsScopeBar = true
        searchBar.scopeButtonTitles = ["All","Missing","Found"]
        searchBar.delegate = self
        
        tableView.tableHeaderView = searchBar
        tableView.tableHeaderView?.backgroundColor = .white
    }
    
    // searchbar text input notifier
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            dataForPlay = data
            tableView.reloadData()
        }else {
            filterTableView(index: searchBar.selectedScopeButtonIndex, text: searchText)
        }
    }
    
    // searchbar scope change notifier
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if selectedScope == 0 {
            dataForPlay = data
            tableView.reloadData()
        }else{
            filterTableView(index: selectedScope)
        }
    }
    
    // custom method to return filter result
    func filterTableView(index: Int, text: String = ""){
        switch index {
        case selectedScope.all.rawValue:
            dataForPlay = data.filter{ (dataArray:[String]) -> Bool in
                return dataArray.filter({ (string: String) -> Bool in
                    return (string.range(of: text, options: .caseInsensitive) != nil)
                }).count > 0
            }
            tableView.reloadData()
            
        case selectedScope.missing.rawValue:
            print("missing")
            dataForPlay = data.filter{ (dataArray:[String]) -> Bool in
                return dataArray.filter({ (string) -> Bool in
                    return string.contains("missing")
                }).count > 0
            }
            tableView.reloadData()
            
        case selectedScope.found.rawValue:
            print("found")
            dataForPlay = data.filter{ (dataArray:[String]) -> Bool in
                return dataArray.filter({ (string) -> Bool in
                    return string.contains("found")
                }).count > 0
            }
            tableView.reloadData()
        default:
            print("no type selected")
        }
    }
    
    
    // MARK:- TableView delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForPlay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = dataForPlay[indexPath.row][0]
        return cell!
    }
    

}

