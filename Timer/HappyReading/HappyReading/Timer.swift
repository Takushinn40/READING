//
//  Timer.swift
//  HappyReading
//
//  Created by cmStudent on 2023/02/17.
//

import SwiftUI

struct Timer: View {
    @State var timeText: String = "0.00"
    @State var isPause: Bool = false
    @State var isStart: Bool = false
    @State private var startTime = Date()
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView{
        VStack(spacing:20){
            titleView()
            readImg()
            timerTextView()
            Spacer()
            // 操作按钮
            if isStart {
                pauseAndResetBtn()
            } else {
                startBtn()
            }
        }            .navigationBarItems(trailing:
                                            NavigationLink(
                                                destination: ContentView(),
                                                label: {Text("ホームページ")
                                                }
                                            )
                    )
                }
            
    }

    func titleView() -> some View{
        HStack{
            Text("今度の読む時間は")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
        }
    }
    
    func readImg() -> some View {
        Image("backgroundTimer")
            .resizable()
            .edgesIgnoringSafeArea(.all)
            .aspectRatio(contentMode: .fill)
    }
    func timerTextView() -> some View {
        Text(timeText)
            .font(.system(size: 48))
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .onReceive(timer) { _ in
                if self.isStart {
                    timeText = String(format: "%.2f", Date().timeIntervalSince(self.startTime))
                }
            }
    }
    //start
    func startBtn() -> some View {
        ZStack {
            Circle()
                .frame(width: 60, height: 60)
                .foregroundColor(.green)
            Image(systemName: "play.fill")
                .foregroundColor(.white)
                .font(.system(size: 32))
        }.onTapGesture {
            self.isStart = true
            timeText = "0.00"
            startTime = Date()
            self.startTimer()
        }
    }
    
    func pauseAndResetBtn() -> some View {
        HStack(spacing: 60) {
            // 暂停按钮
            ZStack {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.red)
                Image(systemName: isPause ? "play.fill" : "pause.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 32))
            }
            .onTapGesture {
                if !isPause {
                    self.isPause = true
                    self.stopTimer()
                } else {
                    self.isPause = false
                    self.startTimer()
                }
            }
            ZStack {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
                Image(systemName: "arrow.uturn.backward.circle.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 32))
            }
            .onTapGesture {
                self.isStart = false
                self.isPause = false
                timeText = "0.00"
            }
        }
    }
    
    
    func startTimer() {
        timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }
    // 停止计时方法
    func stopTimer() {
        timer.upstream.connect().cancel()
    }
}


struct Timer_Previews: PreviewProvider {
    static var previews: some View {
        Timer()
    }
}
