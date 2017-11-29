//
//  User.swift
//  LoadingImages - Exercises
//
//  Created by C4Q on 11/28/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

struct File: Codable {
    let results: [User]
}

struct User: Codable {
    let gender: String
    let name: Name
    let location: Location
    let dob: String
    let phone: String
    let cell: String
    let picture: Picture
    var age: Int {
        let now = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let birthday = formatter.date(from: dob) else {
            return 0
        }
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        return age
    }
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
    var fullName: String {
        return title.capitalized + ". " + first.capitalized + " " + last.capitalized
    }
}

struct Location: Codable {
//    let street: String
//    let city: String
    var contactState: String
    var postCodeInt: Int?
    var postCodeStr: String?
    enum CodingKeys: String, CodingKey {
        case contactState = "state"
        case postCodeInt = "postcode"
        //case postCodeStr
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.contactState = try values.decode(String.self, forKey: .contactState)
        if let pcStr = try? values.decode(String.self, forKey: .postCodeInt) {
            self.postCodeStr = pcStr
        } else if let pcInt = try? values.decode(Int.self, forKey: .postCodeInt) {
            self.postCodeInt = pcInt
        }
    }
}

struct Picture: Codable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}
