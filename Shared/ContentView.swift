//
//  ContentView.swift
//  Shared
//
//  Created by gijuno on 2021/04/23.
//

import SwiftUI

struct ContentView: View {
    public let lines = ["서울 1호선 (서울역 ~ 청량리)", "서울 1호선 (비서울권)", "서울 2호선", "서울 3호선 (대화 ~ 지축)", "서울 3호선 (구파발 ~ 오금)", "서울 4호선 (선바위 ~ 오이도)", "서울 4호선 (당고개 ~ 경마공원)", "서울 5호선", "서울 6호선", "서울 7호선", "서울 8호선", "서울 9호선", "분당선", "경의중앙선", "인천지하철", "신분당선"]
    
    @State private var selectedLine: String = "서울 1호선 (서울역 ~ 청량리)"
    
    var body: some View {
        VStack() {
            NavigationView {
                VStack() {
                    Spacer()
                        .padding(.bottom)
                    Picker("Please choose a line", selection: $selectedLine) {
                        ForEach(lines, id: \.self) {
                            Text($0)
                        }
                    }
                    Group {
                        Text(selectedLine)
                            .padding(.bottom, 15)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                        NavigationLink(destination: WriteView(line: $selectedLine)) { 
                            Text("선택하기")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity,maxHeight:50)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                }.navigationBarTitle("역 선택하기", displayMode: .inline)
                .padding(.bottom, 30)
                .padding(.horizontal, 24)
            }
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ContentView()
            }
        }
    }
}
