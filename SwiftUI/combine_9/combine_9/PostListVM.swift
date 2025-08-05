//
//  PostListVM.swift
//  combine_9
//
//  Created by Dawid Grazawski on 05/08/2025.
//

import Foundation
import Combine

class PostListVM {
    
    @Published var posts: [PostModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching posts: \(error)")
                }
            }, receiveValue: { [weak self] posts in
                self?.posts = posts
            })
            .store(in: &cancellables)
    }
}
