//
//  UserViewmodel.swift
//  RepoArch
//
//  Created by Shashank Gautam on 03/05/26.
//

import SwiftUI
internal import Combine


@MainActor
final class UserViewmodel : ObservableObject {
    @Published var tasks : [UserModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let repo : UserRepo
    
    init(repo : UserRepo){
        self.repo = repo
    }
    
    
    func loadTasks() async {
        isLoading = true
        errorMessage = nil
        do {
            tasks = try await repo.getTasks()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func loadTasksByUserId(userId : Int) async {
        isLoading = true
        errorMessage = nil
        do {
            tasks = try await repo.getTasksByUserId(userId: userId)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
}
