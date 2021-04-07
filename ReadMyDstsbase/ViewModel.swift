//
//  ViewModel.swift
//  ReadMyDstsbase
//
//  Created by Abdullah Alnutayfi on 01/04/2021.
//

import Foundation


class ViewModel: ObservableObject{
    @Published var posts = [Post]()
    
    func loadData(){
        //     1  - - - - - - - -      Create URL
        guard let url = URL(string: "")
        else
        {
            return
        }
        //    2  - - - - - - - -  create Request
        let request = URLRequest(url: url)
        //  3  - - - - - - - -     URL Session
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            //  4  - - - - - - - -     Create Data
            if let data = data{
                //  5 - - - - - - - Create Decoder
                let decoder = JSONDecoder()
                do{
                    // 6 - - - - - - - Create Response
                    let response = try decoder.decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        self.posts = response.posts.values.compactMap{$0}
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
            print(error?.localizedDescription ?? "")
            
            // 6 - - - - - - - - - -  start resume
            
        }.resume()
        
    }
}

struct Response: Codable{
    
    var posts: [String: Post]
}

struct Post: Codable, Identifiable {
    var postID : String
    var caption: String
    var date : String
    var imageDownloadURL : String
    var id: String { postID }
}
