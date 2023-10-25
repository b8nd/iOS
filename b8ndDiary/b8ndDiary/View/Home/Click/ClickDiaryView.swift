//
//  ClickDiaryView.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct ClickDiaryView: View {
    
    @Binding var isClicked: Bool
    @Binding var clickedContent: String
    @State var test: Bool = false
    @State var userName: String = "오스트랄로피테쿠스아파렌시스"
    
    var body: some View {
        
        ZStack {
            
            
            Button {
                isClicked = false
            } label: {
                ZStack {
                    GeometryReader { proxy in
                        Rectangle()
                            .frame(width: proxy.size.width, height: proxy.size.height)
                            .foregroundColor(Colors.Gray2.color)
                            .opacity(0.5)
                    }
                }
            }
            
            VStack {
                Spacer()
                ClickCell(data: clickedContent)
                    .frame(width: 327, height: 319)
                    .overlay {
                        VStack {
                            NavigationLink {
                                ProfileView()
                            } label: {
                                Text("\(userName)")
                                    .font(.system(size: 12))
                                    .frame(width: 100, height: 26)
                                    .foregroundColor(Colors.Blue5.color)
                                    .padding(.leading, 220)
                                    .padding(.top, 20)
                            }
                            
                            Spacer()
                        }
                    }
                Spacer()
                Spacer()
            }
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}