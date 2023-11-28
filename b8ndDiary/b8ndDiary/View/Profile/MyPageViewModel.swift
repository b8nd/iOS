//
//  MyPageViewModel.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 11/21/23.
//

import Foundation





class MyPageViewModel: ObservableObject {
    
//    let postId = MonthPost.shared.postId
    
    var userId: String = ""
    var myuserId : String = ""
    static let shared = MyPageViewModel()
    
    //    @Published var Yeardate : [Bool] = []
    @Published var postCounts: [Int] = [0]
    @Published var numbers: [Int] = [0]
    @Published var number: Int = 0
    
    @Published var username: String = ""
    @Published var userimages: URL? = URL(string: "")
    
    func MyUesrinfo(callback: @escaping () -> Void) {
        Task{
            do {
                
                let MyUserresponse  = try await HttpClient.request(HttpRequest(url: "user/my-info", method:.get, model: UserInfoResponse<MyUserInfoResponse>.self))
                print(MyUserresponse.data)
                myuserId = MyUserresponse.data.userId
                print("자신의 유저 아이디 : \(myuserId)")
                
                
            } catch APIError.responseError(let statusCode) {
                print("myPageViewModel - statusCode: ", statusCode)
            } catch APIError.transportError {
                callback()
            }
        }
    }
    
    func Uesrinfo(callback: @escaping () -> Void) {
        let param = ["userId": userId ]
        Task{
            do {
                
                let Userresponse  = try await HttpClient.request(HttpRequest(url: "user/info", method:.get,params: param , model: UserInfoResponse<UserInfo>.self))
                print(Userresponse.data)
                username = Userresponse.data.name
                if let imageUrl = URL(string: Userresponse.data.images) {
                    userimages = imageUrl
                } else {
                    userimages = nil
                }
                
                
                print("이름 : \(username)")
                print("이미지 : \(String(describing: userimages))")
                
            } catch APIError.responseError(let statusCode) {
                print("myPageViewModel - statusCode: ", statusCode)
            } catch APIError.transportError {
                callback()
            }
        }
    }
    
    func Postdelete(callback: @escaping () -> Void) {
        let body = ["postId": 0]
        Task{
            do {
//                print(" 달 포스트 아이디 확인 : \(postId)")
                let deleteresponse  = try await HttpClient.request(HttpRequest(url: "post/delete", method:.delete ,params: body, model:Response<PostdeleteResponse>.self))
                print("삭제 확인하기 :\(String(describing: deleteresponse.data))")
                
                
            } catch APIError.responseError(let statusCode) {
                print("postdelete - statusCode: ", statusCode)
            } catch APIError.transportError {
                callback()
            }
        }
    }
    
    func postYearCnt(callback: @escaping () -> Void) {
        let params = ["year": 2023, "userId": userId.isEmpty ? myuserId : userId] as [String: Any]
        
        
        Task {
            do {
                let response = try await HttpClient.request(HttpRequest(url: "record/post-cnt", method: .get, params: params, model: PostCntResponse.self))
                print("포스트 갯수 : \(response.data)")
                
                postCounts = response.data
                numbers = response.data
                
                number = numbers.reduce(0, { $0 + $1 })
            } catch APIError.responseError(let statusCode) {
                print("PostcntViewModel - statusCode: ", statusCode)
            } catch APIError.transportError {
                callback()
            }
        }
    }
    
    
    //    func UserpostYearCnt(callback: @escaping () -> Void) {
    //        let params = ["year": 2023 ,"userId": userId] as [String : Any]
    //        Task{
    //            do {
    //                let response  = try await HttpClient.request(HttpRequest(url: "record/post-cnt", method:.get ,params: params , model: PostCntResponse.self))
    //                print(response.data)
    //
    //                postCounts = response.data
    //                numbers = response.data
    //
    //                number = numbers.reduce(0, { $0 + $1 })
    //
    //            } catch APIError.responseError(let statusCode) {
    //                print("myPageViewModel - statusCode: ", statusCode)
    //            } catch APIError.transportError {
    //                callback()
    //            }
    //        }
    //    }
    
    
}



