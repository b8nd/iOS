//
//  HomeViewModel.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 11/15/23.
//

import Foundation
import SwiftUI


final class HomeViewModel : ObservableObject {
    @Published var list: [DataModel] = []
    @Published var topList: [DiaryModel] = []
    
    @Published var offset: CGFloat = 0
    private var originOffset: CGFloat = 0
    private var isCheckedOriginOffset: Bool = false
    
    func setOriginOffset(_ offset: CGFloat) {
        guard !isCheckedOriginOffset else { return }
        self.originOffset = offset
        self.offset = offset
        isCheckedOriginOffset = true
    }
    
    func setOffset(_ offset: CGFloat) {
        guard isCheckedOriginOffset else { return }
        self.offset = offset
    }
    
    
    func initDiaryList(callback: @escaping () -> Void) async {
        do {
            print("home viewmodel - request...")
            let data = try await PostSerivce.getList()
            list = data.data!
            print("home viewmodel - ", list)
        } catch APIError.responseError(let e) {
            print("home viewmodel - ", e)
        } catch APIError.transportError {
            callback()
        } catch (let e) {
            print(e.localizedDescription)
        }
    }
    
    
    func initTopSevenList(callback: @escaping () -> Void) async {
        do {
            let data = try await PostSerivce.getTopSevenList()
            topList = data.data!.map {
                DiaryModel(id: $0.postId,
                           text: $0.content,
                           color: Color.fromString($0.color),
                           image: $0.emoji,
                           uuid: UUID())
            }
        } catch APIError.responseError(let e) {
            print(e)
        } catch (let e) {
            print(e.localizedDescription)
            callback()
        }
    }
}
