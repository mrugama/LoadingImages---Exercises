//
//  UserAPIClient.swift
//  LoadingImages - Exercises
//
//  Created by C4Q on 11/28/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

struct UserAPIClient {
    private init() {}
    static let manager = UserAPIClient()
    func getUsers(from urlStr: String,
                  completionHandler: @escaping ([User]) -> Void,
                  errorHandler: @escaping (AppError) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHandler(.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let userInfo = try JSONDecoder().decode(File.self, from: data)
                let users = userInfo.results
                completionHandler(users)
                return
            }
            catch {
                errorHandler(.couldNotParseJSON(rawError: error))
                return
            }
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}
