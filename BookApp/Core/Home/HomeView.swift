//
//  HomeView.swift
//  BookApp
//
//  Created by Revan Sadigli on 31.03.2023.
//

import SwiftUI
import Kingfisher



struct HomeScreen: View {
    @StateObject var viewModel = HomeViewModel()

    @State private var search: String = ""
    @State private var selectedIndex: Int = 1
    
    private let categories = ["All", "Crime", "Horror", "Thriller", "Classic", "Science"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(#colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1))
                    .ignoresSafeArea()
                
                ScrollView (showsIndicators: false) {
                    VStack (alignment: .leading) {
                        
                        
                        TagLineView()
                            .padding()
                        
                        SearchAndScanView(search: $search)
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< categories.count) { i in
                                    
                                    Button(action: {selectedIndex = i}) {
                                        CategoryView(viewModel: viewModel,
                                                    isActive: selectedIndex == i, text: categories[i])
                                    
                                        
                                    }
                                
                                }
                            }
                            .padding()
                        }
                        
                        Text("Popular")
                            .font(.custom("PlayfairDisplay-Bold", size: 24))
                            .padding(.horizontal)
                        
                        Books(viewModel: viewModel)
                        
                        Text("Best")
                            .font(.custom("PlayfairDisplay-Bold", size: 24))
                            .padding(.horizontal)
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            VStack (spacing: 0) {
                                ForEach(0 ..< 4) { i in
                                    BestBooks(viewModel: viewModel)
                                }
                                .padding(.leading)
                            }
                        }
                        
                    }
                }
                
                VStack {
                    Spacer()
                    BottomNavBarView()
                }
            }
        }.navigationViewStyle(.stack)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}


struct TagLineView: View {
    var body: some View {
        Text("Find Books ")
            .font(.custom("PlayfairDisplay-Regular", size: 28))
            .foregroundColor(Color("Primary"))
            + Text("")
            .font(.custom("PlayfairDisplay-Bold", size: 28))
            .fontWeight(.bold)
            .foregroundColor(Color("Primary"))
    }
}

struct SearchAndScanView: View {
    @Binding var search: String
    var body: some View {
        HStack {
            HStack {
                Image("Search")
                    .padding(.trailing, 8)
                TextField("Search Books", text: $search)
            }
            .padding(.all, 20)
            .background(Color.white)
            .cornerRadius(10.0)
            .padding(.trailing, 8)
            
            Button(action: {}) {
                Image("menu")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10.0)
            }
        }
        .padding(.horizontal)
    }
}

struct CategoryView: View {
    @StateObject var viewModel: HomeViewModel

    let isActive: Bool
    let text: String
    
    
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(isActive ? Color("Primary") : Color.black.opacity(0.5))
                .onTapGesture {
                   viewModel.getBooks(categories: text)
                }
            if (isActive) { Color("Primary")
                .frame(width: 15, height: 2)
                .clipShape(Capsule())
            }
           
        }
        .padding(.trailing)
    }
}

struct Book: View {
    
    let result: BookInfo
    let size: CGFloat = 210
    
    var body: some View {
        VStack {
            KFImage(URL(string: result.image))
                .resizable()
                .frame(width: size, height: 200 * (size/210))
                .cornerRadius(20.0)
            Text(result.title).font(.title3).fontWeight(.bold)
            
            HStack (spacing: 2) {
                ForEach(0 ..< 5) { item in
                    Image("star")
                }
                Spacer()
                Text(result.price)
                    .font(.title3)
                    .fontWeight(.bold)
            }
        }
        .frame(width: size)
        .padding()
        .background(Color.white)
        .cornerRadius(20.0)
        
    }
}


struct BottomNavBarView: View {
    var body: some View {
        HStack {
            BottomNavBarItem(image: Image("Home"), action: {})
            BottomNavBarItem(image: Image("fav"), action: {})
            BottomNavBarItem(image: Image("shop"), action: {})
            BottomNavBarItem(image: Image("User"), action: {})
        }
        .padding()
        .background(Color.white)
        .clipShape(Capsule())
        .padding(.horizontal)
        .shadow(color: Color.blue.opacity(0.15), radius: 8, x: 2, y: 6)
    }
}

struct BottomNavBarItem: View {
    let image: Image
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            image
                .frame(maxWidth: .infinity)
        }
    }
}


struct Books: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack (spacing: 0) {
                ForEach(viewModel.popularBooks) { book in
                    NavigationLink(
                        destination: BookDetailScreen(bookDetail: book),
                        label: {
                            Book(result: book)
                        })
                    .navigationBarHidden(true)
                    .foregroundColor(.black)
                    .navigationSplitViewStyle(.automatic)
                }
                .padding(.leading)
            }
        }
        .padding(.bottom)
        
    }
}


struct BestBooks: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        ScrollView (.horizontal, showsIndicators: true) {
            VStack (spacing: 10) {
                ForEach(viewModel.bestBooks) { book in
                    NavigationLink(
                        destination: BookDetailScreen( bookDetail: book),
                        label: {
                            BestBook(result: book)
                            Spacer()
                        })
                    .navigationBarHidden(true)
                    .foregroundColor(.black)
                }
            }
        }
        .padding(.bottom)
        
    }
}


struct BestBook: View {
    let result: BookInfo
    
    var body: some View {
        HStack (alignment: .top, spacing: 0){
            KFImage(URL(string: result.image))
                .resizable()
                .frame(
                      minWidth: 80,
                      maxWidth: 100,
                      minHeight: 80,
                      maxHeight: 100,
                      alignment: .topLeading
                    )
                .cornerRadius(5.0)
            VStack (alignment: .leading, spacing: 2) {
                Text(result.title).font(.title3).fontWeight(.bold).padding(10.0)
                
                HStack (spacing: 2) {
                    ForEach(0 ..< 5) { item in
                        Image("star")
                    }
                   Spacer()
                    Text(result.price)
                        .font(.title3)
                        .fontWeight(.bold)
                }
            }
        }
        .frame(
              minWidth: 0,
              maxWidth: UIScreen.screenWidth - 70,
              minHeight: 0,
              maxHeight: .infinity,
              alignment: .topLeading
            )
        .padding(20.0)
        .background(Color.white)
        .cornerRadius(20.0)
        
    }
}
