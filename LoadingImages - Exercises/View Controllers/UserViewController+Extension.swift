//
//  UserViewController+Extension.swift
//  LoadingImages - Exercises
//
//  Created by C4Q on 11/28/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.userTableView.dequeueReusableCell(withIdentifier: "User Cell", for: indexPath) as? UserTableViewCell
        let user = users[indexPath.row]
        cell?.nameLabel.text = "Name: \(user.name.fullName)"
        cell?.ageLabel.text = "Age: \(user.age)"
        cell?.cellPhone.text = "CellPhone: \(user.cell)"
        cell?.userImageView.image = nil //Gets rid of flickering
        guard let imageUrlStr = user.picture.medium else {
            return cell!
        }
        let completion: (UIImage) -> Void = {(onlineImage: UIImage) in
            cell?.userImageView.image = onlineImage
            cell?.setNeedsLayout() //Makes the image load as soon as it's ready
        }
        ImageAPIClient.manager.getImage(from: imageUrlStr,
                                        completionHandler: completion,
                                        errorHandler: {print($0)})
        return cell!
    }
    
}
