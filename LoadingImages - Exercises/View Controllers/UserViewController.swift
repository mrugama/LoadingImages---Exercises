//
//  UserViewController.swift
//  LoadingImages - Exercises
//
//  Created by C4Q on 11/28/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    
    var users = [User]() {
        didSet {
            userTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userTableView.delegate = self
        self.userTableView.dataSource = self
        loadData()
    }
    func loadData() {
        let urlStr = "https://randomuser.me/api/?page=1&nat=us&results=10"
        
        let completion: ([User]) -> Void = {(onlineUsers: [User]) in
            self.users = onlineUsers
        }
        let errorHandler: (AppError) -> Void = {(error: AppError) in
            switch error {
            //To Do - Don't load erros into search bar
            case .couldNotParseJSON(let error):
                print("JSONError: \(error)")
            case .noInternetConnection:
                print("No internet connection")
            default:
                print("Other error")
            }
        }
        
        UserAPIClient.manager.getUsers(from: urlStr,
                                       completionHandler: completion,
                                       errorHandler: errorHandler)
    }
}


