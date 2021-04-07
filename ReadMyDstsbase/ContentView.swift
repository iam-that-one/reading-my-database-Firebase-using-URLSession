//
//  ContentView.swift
//  ReadMyDstsbase
//
//  Created by Abdullah Alnutayfi on 01/04/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    var body: some View {
        VStack(alignment:.leading){
            ScrollView{
                VStack(alignment:.leading){
                    ForEach(vm.posts){ post in
                        
                        Image(uiImage: UIImage(data: loadImage(url1: post.imageDownloadURL) ?? Data()) ?? UIImage())
                            .resizable()
                            .frame(width: 400, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Text(post.caption)
                    }
                }
            }
        }.onAppear{vm.loadData()}
    }
    func loadImage(url1 : String) -> Data?{
        let url = URL(string: url1)!
        
        // Fetch Image Data
        if let data = try? Data(contentsOf: url) {
            // Return Image as Data
            return data
        }
        return nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
