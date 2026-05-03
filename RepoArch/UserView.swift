//
//  ContentView.swift
//  RepoArch
//
//  Created by Shashank Gautam on 03/05/26.
//

import SwiftUI

struct UserView: View {
    @StateObject private var viewModel : UserViewmodel
    init(viewModel: UserViewmodel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        VStack {
            HStack {
                Text("Todo List")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Menu {
                    ForEach(UserIdConstants.userIdArray,id: \.self){ userId in
                        Button {
                            Task{
                                await viewModel.loadTasksByUserId(userId: userId)
                            }
                        } label: {
                            Text(userId.description)
                        }

                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 28, height: 28)
                }
                
            }
            .padding(.init(top: 8, leading: 12, bottom: 0, trailing: 24))
            Spacer()
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundStyle(Color.red)
                    .font(.headline)
                    .fontWeight(.bold)
            } else {
                List(viewModel.tasks,id: \.id){ task in
                    HStack{
                        Text(task.userId.description)
                            .font(.subheadline)
                        Text(task.title)
                            .font(.subheadline)
                            .lineLimit(2)
                            .frame(width: 220,alignment: .leading)
                        Spacer()
                        Image(systemName: task.completed ? "checkmark.square" : "square")
                            .resizable()
                            .frame(width: 20,height: 20)
                            .foregroundStyle(.green)
                            
                    }
                }
            }
            Spacer()
        }
        .task {
            await viewModel.loadTasks()
        }
    }
}

#Preview {
    let apiservice = UserAPIService()
    let userRepo = UserRepo(userApiService: apiservice)
    let userVM = UserViewmodel(repo: userRepo)
    UserView(viewModel: userVM)
}
