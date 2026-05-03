//
//  UserModel.swift
//  RepoArch
//
//  Created by Shashank Gautam on 03/05/26.
//

import Foundation

struct UserModel : Codable{
    let id : Int
    let userId : Int
    let title : String
    let completed : Bool
}
