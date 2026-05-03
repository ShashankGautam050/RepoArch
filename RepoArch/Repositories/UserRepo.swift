//
//  UserRepo.swift
//  RepoArch
//
//  Created by Shashank Gautam on 03/05/26.
//

import Foundation

actor UserRepo{
    private let userApiService : UserAPIService
    private var cache : [UserModel]?
    
    init(userApiService : UserAPIService){
        self.userApiService = userApiService
    }
        func getTasks() async throws -> [UserModel] {
            if let cache = cache {
                print("returned from cache")
                return cache
            }
            
            let tasks = try await userApiService.fetchTasks()
            self.cache = tasks
            return tasks
        }
    
    func getTasksByUserId(userId : Int) async throws -> [UserModel] {
        if let cache = cache {
            print("returned from cache")
            return cache.filter { $0.userId == userId}
        }
        
        let tasks = try await userApiService.fetchTaskByUserId(userId:userId)
        self.cache = tasks
        return tasks
    }
    
}
