//
//  PostViewModel.swift
//  b8ndDiary
//
//  Created by dgsw8th71 on 11/20/23.
//

import Foundation
import SwiftUI
import Alamofire


class PostViewModel : ObservableObject {
    
    @Published var text: String = ""
    @Published var isSecret: Bool = true
    @Published var backgroundColor: Color = Colors.Blue1.color
    @Published var selectedEmoji: String = "DefaultEmoji"
    
    @MainActor
    func post(complete: @escaping () -> Void, 
              error: @escaping () -> Void,
              error2: @escaping () -> Void
    ) {
        Task {
            do {
                print(text, changeColor(color: backgroundColor), selectedEmoji, isSecret)
                let response = try await HttpClient.request(
                    HttpRequest(url: "post/create",
                                method: .post,
                                params: ["content": text,
                                         "color": changeColor(color: backgroundColor), //Color.toString(backgroundColor)
                                         "emoji":selectedEmoji,
                                         "isSecret":isSecret],
                                model: Response<String>.self))
                print("post -", response.data ?? "")
                complete()
            } catch APIError.responseError(let e) {
                print(e)
                error()
            } catch APIError.transportError {
                error2()
            }
        }
    }

    func changeColor(color: Color) -> String {
        
        var memoColor: String = ""
        
        switch backgroundColor {
        case Colors.Blue1.color:
            memoColor = "skyBlue"
        case Colors.Blue2.color:
            memoColor =  "blue"
        case Colors.Blue3.color:
            memoColor = "darkBlue"
        case Colors.Yellow1.color:
            memoColor = "yellow"
        default:
            print("색 오류")
        }
        return memoColor
    }
    func PostRead(postNum: Int, callback: @escaping () -> Void) {
        let param = postNum
        Task {
            do {
                let readresponse = try await HttpClient.request(HttpRequest(url: "post/read/\(param)", method:.get, model:Response<DataModel>.self))
                print(readresponse)

              
            
                   text = readresponse.data?.content ?? ""
                    isSecret = readresponse.data?.isSecret ?? true
                    selectedEmoji = readresponse.data?.emoji ?? "DefaultEmoji"
                
            } catch APIError.responseError(let statusCode) {
                print("postdelete - statusCode: ", statusCode)
            } catch APIError.transportError {
                callback()
            }
        }
    }
    
    @MainActor
    func Postupdate(postNum: Int, complete: @escaping () -> Void,
                    error: @escaping () -> Void,
                    error2: @escaping () -> Void) {
        let body : Parameters = [
            "postId" : postNum, 
            "content": text,
            "color": changeColor(color: backgroundColor),
            "emoji": selectedEmoji,
            "isSecret": isSecret
        ]

        Task {
            do {
                let updateresponse  = try await HttpClient.request(HttpRequest(url: "post/update", method: .patch, params: body, model: PostupdateResponse.self))
                print(updateresponse)
                complete()
            } catch APIError.responseError(let e) {
                print(e)
                error()
            } catch APIError.transportError {
                error2()
            }
        }
    }


}
