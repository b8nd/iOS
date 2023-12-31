//
//  MyPageView.swift
//  GoogleLogin
//
//  Created by dgsw8th61 on 2023/10/03.
//

import SwiftUI
import GoogleSignIn

struct UserPageView: View {
    var test : Bool = true
    
    var userData: UserData
    
    @State private var selectedYear = "2023년"
    @State private var selectedMonth : Int = 0
    // 화면 종료
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    @State var date = Date()
    @ObservedObject var viewModel = UserPageViewModel()
    @State var userId: String = ""
    
    
    let yesrs = ["2023년"]
    let days = ["일", "월", "화", "수", "목", "금","토"]
    let months = [1,2,3,4,5,6,7,8,9,10,11,12]
    
    func createDayViews(for days: [String]) -> some View {
        ForEach(days, id: \.self) { day in
            VStack {
                Text(day)
                    .font(.system(size: 10))
                    .padding(.vertical,3)
                    .foregroundColor(.black)
            }
        }
    }
    
    
    
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false){
                VStack{
                    HStack(alignment: .top){
                        AsyncImage(url: viewModel.userimages)
                            .aspectRatio(contentMode: .fit)
                            .imageScale(.small)
                            .frame(width: 100, height: 100, alignment: .center)
                            .cornerRadius(50)
                            .overlay {
                                Circle().stroke(.white, lineWidth: 2)
                            }
                            .padding(EdgeInsets(top: 60, leading: 20, bottom: 0, trailing: 0))
                            .overlay(
                                ZStack {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 30, height: 30)
                                    
                                    Button(action: {
                                        // 버튼 동작 구현
                                    }, label: {
                                        NavigationLink(destination: UserPage()) {
                                            Image(systemName: "pencil")
                                                .foregroundColor(.white)
                                                .font(.system(size: 15))
                                        }
                                    })
                                    
                                }
                                    .offset(x: 45, y: 65) // 위치 조정
                            )
                        Text(viewModel.username)
                            .font(.system(size: 23 ))
                            .bold()
                            .padding(EdgeInsets(top: 95, leading: 30, bottom: 0, trailing: 0))
                    }
                    .padding(.trailing, 100)
                    .padding(.bottom,10)
                    HStack{
                        YearCalendar(userId: $userId)
                            .padding(.vertical,40)
                            .padding(.horizontal,30)
                    }
                    .overlay {
                        HStack{
                            VStack{
                                createDayViews(for: days)
                            }
                            .padding(.leading,10)
                            .padding(.top,23)
                            Spacer()
                        }
                    }
                    
                    
                    Spacer()
                    VStack{//작성글 시작
                        HStack{
                            Text("작성글")
                                .font(.system(size: 20))
                                .padding(.trailing , 110 )
                            VStack{
                                Text("총 \(viewModel.number)장")
                                    .font(Font.custom("Pretendard", size: 12))
                                    .kerning(0.1)
                                    .foregroundColor(Color(red: 0.29, green: 0.33, blue: 0.41))
                                    .padding(.trailing, 43)
                                    .offset(x:7,y:10)
                                
                                Picker("Choose", selection: $selectedYear) {
                                    ForEach(yesrs, id: \.self) {
                                        Text($0)
                                    }
                                }
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0, green: 0.52, blue: 0.93), lineWidth: 1)
                            )
                            .padding(.leading,70)
                            
                        }
                        .padding(10)
                        
                        VStack {
                            ForEach(Array(zip(months,viewModel.postCounts)), id: \.0) { month,count in
                                NavigationLink(
                                    
                                    destination: UserMonthPage(userId: $userId, selectedMonth: month),
                                    label: {
                                        HStack {
                                            Text("\(month)월")
                                                .padding(.leading, 30)
                                                .bold()
                                                .foregroundColor(.black)
                                            
                                            Spacer()
                                            
                                            Text("\(count)장")
                                                .padding(.trailing, 30)
                                                .foregroundColor(Colors.Gray3.color)
                                                .opacity(0.5)
                                                .font(.system(size: 10))
                                        }
                                        .background(
                                            Rectangle()
                                                .foregroundColor(Colors.Gray1.color)
                                                .frame(width: 340, height: 40)
                                                .cornerRadius(10)
                                            
                                        )
                                    }
                                )
                                .padding(.bottom, 20)
                            }
                        }
                        .padding(20)
                    }
                }
            }
        }
        .onAppear {
            viewModel.userId = userId
            viewModel.Uesrinfo(callback: {
                
            })
            viewModel.postYearCnt(callback: {
                
            })
            
            print("유저 아이디 확인하기 : \(userId)")
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitle(
            "",
            displayMode: .inline
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("프로필")
                    .bold()
                    .foregroundColor(.black)
                    .font(.system(size: 15))
            }
        }
        .navigationBarItems(
            leading:
                HStack(spacing: 16) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "multiply")
                            .foregroundColor(.black)
                    })
                    
                    Spacer()
                }
        )
    }
}
