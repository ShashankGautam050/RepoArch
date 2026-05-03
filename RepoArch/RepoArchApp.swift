//
//  RepoArchApp.swift
//  RepoArch
//
//  Created by Shashank Gautam on 03/05/26.
//

import SwiftUI

@main
struct RepoArchApp: App {
    var body: some Scene {
        WindowGroup {
            let userAPI = UserAPIService()
            let userRepo = UserRepo(userApiService: userAPI)
            let viewModel = UserViewmodel(repo: userRepo)
            
            UserView(viewModel: viewModel)
        }
    }
}
