//
//  ContentView.swift
//  Instagram_iOS
//
//  Created by Jean Silvany on 29/08/23.
//

import SwiftUI

struct HeaderView: View {
    @State private var showMessageAlert: Bool = false
    @State private var showChevronAlert: Bool = false
    @State private var showHeartAlert: Bool = false
    
    var body: some View {
        HStack {
            HStack{
                AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Instagram_logo.svg/800px-Instagram_logo.svg.png")){
                    image in image.image?.resizable().scaledToFill().frame(width: 120, height: 50)
                }
                Button(action: {
                    showChevronAlert = !showChevronAlert
                }){
                    Image(systemName: "chevron.down").foregroundColor(.black)
                }.alert(isPresented: $showChevronAlert){
                    Alert(title: Text("Chevron Alert"))
                }
            }.font(.title)
            
            Spacer()
            
            HStack {
                Button(action: {
                    showHeartAlert = !showHeartAlert
                }){
                    Image(systemName: "heart").foregroundColor(.black)
                }.alert(isPresented: $showHeartAlert) {
                    Alert(title: Text("Heart Alert"))
                }
                Button(action: {
                    showMessageAlert = !showMessageAlert
                }){
                    Image(systemName: "message").foregroundColor(.black)
                }.alert(isPresented: $showMessageAlert){
                    Alert(title: Text("Message Alert "))
                }
            }.font(.title)
            
        }.padding(.horizontal)
    }
}

struct ContentView: View {
    
    
    var body: some View {
        VStack{
            HeaderView()
            CarouselView()
            Spacer()
        }
    }
}

struct CircleImageView: View {
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    var hasBorder: Bool
    
    let imageUrl: String = "https://picsum.photos/100/100"
    
    let myGradient = Gradient(
        colors: [
            .yellow,
            .red
        ]
    )
    
    var body: some View {
        let shape = AsyncImage(url: URL(string: imageUrl)) { image in
            image
                .resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
            .frame(width: imageWidth, height: imageHeight)
            .background(Color.gray)
            .clipShape(Circle())
            .shadow(radius: 2)
        
        
        if hasBorder {
            shape
                .overlay(RoundedRectangle(cornerRadius: 50)
                    .strokeBorder(
                        LinearGradient(
                            gradient: myGradient,
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        , lineWidth: 2))
        } else {
            shape
        }
        
    }
}


struct CarouselView: View {
    let myGradient = Gradient(
        colors: [
            .purple,
            .yellow,
            .red,
            .purple
        ]
    )
    
    var body: some View {
        let shape = Button(action: {}){
            CircleImageView(imageWidth: 90, imageHeight: 90, hasBorder: true)
        }
        ScrollView (.horizontal, showsIndicators: false){
            LazyHGrid(rows: [GridItem()], spacing: 12) {
                ForEach(0...15, id: \.self){ item in
                    shape
                }
            }
        }.frame(maxHeight: 90).padding(.leading, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
