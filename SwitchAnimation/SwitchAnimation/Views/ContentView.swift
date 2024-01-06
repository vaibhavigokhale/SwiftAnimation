//
//  ContentView.swift
//  SwitchAnimation
//
//  Created by Admin on 05/01/24.
//

import SwiftUI

struct PostView: View {
    let post: Post
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(uiImage:UIImage(imageLiteralResourceName: post.image))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                
                VStack (alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                    Text(post.date, style: .date)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
            }
        }
        .frame(maxWidth: .infinity)
        
        Divider()
    }
}

struct GridPostView: View {
    let post: Post
    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage: UIImage(imageLiteralResourceName: post.image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
            
            Text(post.title)
                .bold()
            
            Text(post.date, style: .date)
                .font(.footnote)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView: View {
    @State private var isGridView = false
    @State private var posts: [Post] = []
    
    var body: some View {
        VStack (alignment: .leading) {
            Toggle(isOn: $isGridView) {
                Text("Switch View")
            }
            .padding()
            
            if isGridView {
                // Grid View
                ScrollView {
                    LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 3)) {
                        ForEach(posts) { post in
                            GridPostView(post: post)
                                .padding()
                        }
                    }
                    .transition(.scale)
                    .onAppear(perform: {
                        posts = loadPosts()
                    })
                }
                
                
            } else {
                // List View
                List {
                    VStack(alignment: .leading) {
                        ForEach(posts) { post in
                            PostView(post: post)
                                .padding()
                        }
                    }
                    .transition(.scale)
                    .onAppear(perform: {
                        posts = loadPosts()
                    })
    
                }
            }
        }
        .animation(.default, value: isGridView)
        
        Spacer()
    }
}
