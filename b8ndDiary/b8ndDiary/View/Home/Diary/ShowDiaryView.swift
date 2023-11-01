//
//  ShowDiaryView.swift
//  b8ndDiary
//
//  Created by dgsw8th36 on 2023/10/11.
//

import SwiftUI

struct ShowDiaryView: View {
    
    @Binding var isClicked: Bool
    @Binding var clickedContent: String
    
    @Binding var day: Int
    
    var diaryContent: [String] = ["오늘도 바인드를 회의를 했는데 이번 아이디어가 매우 좋은 것 같아서 행복했다. 그리고 나중에", "개발을 했다1", "개발을 했다2", "개발을 했다3", "개발을 했다4", "개발을 했다5", "개발을 했다6", "개발을 했다7", "개발을 했다8", "개발을 했다9", "개발을 했다10", "개발을 했다11", "개발을 했다12", "개발을 했다13", "개발을 했다14", "개발을 했다15", "개발을 했다16", "개발을 했다17", "개발을 했다18", "개발을 했다19", "개발을 했다20", "개발을 했다21", "개발을 했다22", "개발을 했다23", "개발을 했다24", "개발을 했다25", "개발을 했다26", "개발을 했다27", "개발을 했다28", "개발을 했다29", "개발을 했다30", "개발을 했다31", "개발을 했다32", "개발을 했다33", "개발을 했다34", "개발을 했다35", "개발을 했다36", "개발을 했다37", "개발을 했다38", "개발을 했다39", "개발을 했다40", "개발을 했다41", "개발을 했다42", "개발을 했다43", "개발을 했다44", "개발을 했다45", "개발을 했다46", "개발을 했다47", "개발을 했다48", "개발을 했다49", "개발을 했다50", "개발을 했다51", "개발을 했다52", "개발을 했다53", "개발을 했다54", "개발을 했다55", "개발을 했다56", "개발을 했다57", "개발을 했다58", "개발을 했다59", "개발을 했다60", "개발을 했다61", "개발을 했다62", "개발을 했다63", "개발을 했다64", "개발을 했다65", "개발을 했다66", "개발을 했다67", "개발을 했다68", "개발을 했다69", "개발을 했다70", "개발을 했다71", "개발을 했다72", "개발을 했다73", "개발을 했다74", "개발을 했다75", "개발을 했다76", "개발을 했다77", "개발을 했다78", "개발을 했다79", "개발을 했다80", "개발을 했다81", "개발을 했다82", "개발을 했다83", "개발을 했다84", "개발을 했다85", "개발을 했다86", "개발을 했다87", "개발을 했다88", "개발을 했다89", "개발을 했다90", "개발을 했다91", "개발을 했다92", "개발을 했다93", "개발을 했다94", "개발을 했다95", "개발을 했다96", "개발을 했다97", "개발을 했다98", "개발을 했다99", "개발을 했다 100"]
    
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(diaryContent, id: \.self) { content in
                Button {
                    isClicked = true
                    clickedContent = content
                } label: {
                    DiaryCell(data: content)
                        .frame(width: 150, height: 150)
                }
            }
        }
    }
}
