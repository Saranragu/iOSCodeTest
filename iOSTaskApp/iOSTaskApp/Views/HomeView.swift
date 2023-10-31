//
//  HomeView.swift
//  iOSTaskApp
//
//  Created by Saravanan R on 26/10/23.
//

import SwiftUI

struct HomeView: View {
    
   @StateObject var viewModel = NewsViewModelCall(service: NewsServiceCall())
    
    var body: some View {
        
        Group{
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error) {
                    self.viewModel.getArticles()
                }
            case .success(let content):
                NavigationView {
                    List(content) { article in
                        NavigationLink {
                            NewsDetailView(article: article)
                        } label: {
                            MoviesRow(article: article)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .navigationBarTitle("News")
                }
            }
        }.onAppear(perform: viewModel.getArticles)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
