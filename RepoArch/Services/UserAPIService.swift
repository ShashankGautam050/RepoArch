//
//  UserAPIService.swift
//  RepoArch
//
//  Created by Shashank Gautam on 03/05/26.
//

import Foundation

final class UserAPIService{
    
    func fetchTasks() async throws -> [UserModel]{
        guard let baseURL = APIConstants.baseURL else {
            throw URLError(.badURL)
        }
        
        // there are two ways to accomplish this to add uri in base url either we can use appendingPathComponent or URLComponents
        // differences
        //appendingPathComponent -> this is being used when the api is simple and clean no filters,pagination and qyery parameters are required.
        //URLComponents -> this is being used when the api is complex filters,pagination and qyery parameters are required.
        let url = baseURL.appending(path: "todos")
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
       guard let httpResponse = response as? HTTPURLResponse,200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        
        return try JSONDecoder().decode([UserModel].self, from: data)
    }
    
    func fetchTaskByUserId(userId : Int) async throws -> [UserModel]{
        var components = URLComponents(url: APIConstants.baseURL!, resolvingAgainstBaseURL: false)
        
        components?.path = "todos"
        components?.queryItems = [
            URLQueryItem(name: "userId", value: "\(userId)")
        ]
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([UserModel].self, from: data)
    }
}
