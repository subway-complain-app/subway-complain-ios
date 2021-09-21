//
//  WriteView.swift
//  subway
//
//  Created by gijuno on 2021/04/26.
//

//정보 = \(노선) \(방면)행 \(다음역) 가는 \(편성)편성 \(호칸)호칸 \(내용) \(추가내용)

import SwiftUI

struct WriteView: View {
    
    @Binding var line: String
    @State var boundTo: String = ""
    @State var nextStation: String = ""
    @State var trainNum: String = ""
    @State var unit: String = ""
    @State var content: String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Group {
                        Group {
                            Text("방면 입력")
                                .padding(.top, 20)
                            TextField("ㅇㅇ행", text: $boundTo)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Text("다음역 입력").padding(.top, 20)
                            TextField("ㅇㅇ역", text: $nextStation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Text("편성 입력")
                                .padding(.top, 20)
                            TextField("####", text: $trainNum)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                            
                            Text("호차 입력")
                                .padding(.top, 20)
                            TextField("#", text: $unit)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad)
                            
                            Text("신고 내용 입력").padding(.top, 20)
                            TextField("민원,신고 내용 작성", text: $content)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        Text(setMessageContent(
                            line: line,
                            boundTo: boundTo,
                            nextStation: nextStation,
                            trainNum: trainNum,
                            unit: unit,
                            content: content
                        ))
                        .padding(.top, 20)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    }
                }.padding(.horizontal, 24)
            }.navigationBarTitle("신고 정보 입력", displayMode: .inline)
            Group {
                Button(action: {
                    sendMessage(
                        phoneNumber: phoneNumberFromLine(line: line),
                        messageContent: setMessageContent(
                            line: line,
                            boundTo: boundTo,
                            nextStation: nextStation,
                            trainNum: trainNum,
                            unit: unit,
                            content: content
                        )
                    )
                }, label: {
                    Text("신고하기")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(
                            maxWidth: .infinity,
                            minHeight: 50,
                            maxHeight:50
                        )
                        .background(Color.blue)
                        .cornerRadius(10)
                }).padding(.top, 20)
            }.frame(alignment: .bottom)
            .padding(.horizontal, 24)
        }.padding(.bottom, 30)
    }
}


struct WriteView_Previews: PreviewProvider {
    static var previews: some View {
        WriteView(line: .constant("selected line"))
    }
}


func setMessageContent(
    line: String,
    boundTo: String,
    nextStation: String,
    trainNum: String,
    unit: String,
    content: String) -> String {
    
    var _unit = unit
    if (unit != "") {
        _unit = " \(unit)호칸"
    }

    return "\(line) \(boundTo)행 \(nextStation) 가는 \(trainNum)편성\(_unit)에 \(content)"
}


func phoneNumberFromLine(line: String) -> String {
    let lines = ContentView().lines
    
    switch line {
        case lines[0], lines[2], lines[4], lines[6], lines[7], lines[8], lines[9], lines[10]:
            return "1577-1234"
        case lines[1], lines[3], lines[5], lines[12], lines[13]:
            return "1544-7769"
        case lines[11]:
            return "1544-4009"
        case lines[14]:
            return "032-451-2114"
        case lines[15]:
            return "031-8018-7777"
        default:
            return ""
    }
}


func sendMessage(phoneNumber: String, messageContent: String) {
    let sms: String = "sms:\(phoneNumber)&body=\(messageContent)"
    let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
}
