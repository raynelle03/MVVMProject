//
//  APIClient.swift
//  JEDemo
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//


import Alamofire

class APIClient {
     // MARK: - GET POSTS
     func getPosts(completion:@escaping (_ response: [Post]?, _ error: String?)->Void) {
        AF.request(APIPosts.allposts)
            .responseDecodable { (response: DataResponse<[Post]>) in
                print("POSTS---\(response)")
                switch response.result {
                case .success:
                            completion(response.value, nil)
                case .failure(let error):
                        print(error.localizedDescription)
                        completion(nil, error.localizedDescription)
                }
        }
    }

    // MARK: - GET COMMENTS
    func getComments(postId: Int, completion:@escaping (_ response: [Comment]?, _ error: String?)->Void) {
        let postIdString = String(postId)
        AF.request(APIComments.comments(postId: postIdString))
            .responseDecodable { (response: DataResponse<[Comment]>) in
                print("COMMENTS---\(response)")
                switch response.result {
                case .success:
                    completion(response.value, nil)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil, error.localizedDescription)
                }
        }
    }

    // MARK: - GET USERS
    func getUsers(completion:@escaping (_ response: [User]?, _ error: String?)->Void) {
        AF.request(APIUsers.allusers)
            .responseDecodable { (response: DataResponse<[User]>) in
                print("USERS---\(response)")
                switch response.result {
                case .success:
                    completion(response.value, nil)
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil, error.localizedDescription)
                }
        }
    }
}






