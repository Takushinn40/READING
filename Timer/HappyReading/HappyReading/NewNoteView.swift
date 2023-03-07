//
//  NewNoteView.swift
//  HappyReading
//
//  Created by cmStudent on 2023/02/03.
//

import SwiftUI


struct NewNoteView: View {
    @EnvironmentObject var viewModel: ViewModel
    
    @State var noteModel : NoteModel
    
    @Environment(\.presentationMode) var presentationMode
    

    var body: some View {
        
        NavigationView{
            VStack{
                Divider()
                titleView()
                Divider()
                contentView()
            }
            .navigationBarTitle(viewModel.isAdd ? "新本を追加" : "本を直します", displayMode: .inline)
            .navigationBarItems(leading: closeBtnView(), trailing: saveBtnView())
            .toast(present: $viewModel.showToast, message: $viewModel.showToastMessage)
        }
    }
    
    //关闭
    
    func closeBtnView() -> some View{
        Button(action : {
            self.presentationMode.wrappedValue.dismiss()
        }){
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 17))
                .foregroundColor(.gray)
        }
    }
    
    //完成
    
    func saveBtnView()  -> some View{
        Button(action : {
            if viewModel.isAdd {
                if viewModel.isTextEmpty(text: viewModel.title){
                    viewModel.showToast = true
                    viewModel.showToastMessage = "本の名を入力してください"
                } else if viewModel.isTextEmpty(text: viewModel.content){
                    viewModel.showToast = true
                    viewModel.showToastMessage = "本のページ数を入力してください"
                } else {
                    self.viewModel.addItem(writeTime: viewModel.getCurrentTime(), title: viewModel.title, content: viewModel.content)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }else {
                
                //判断标题是否为空
                if viewModel.isTextEmpty(text: noteModel.title) {
                    viewModel.showToast = true
                    viewModel.showToastMessage = "本の名無しはダメです"
                }
                
                //判断内容是否为空
                else if viewModel.isTextEmpty(text: noteModel.content) {
                    viewModel.showToast = true
                    viewModel.showToastMessage = "ページ数は無しはダメです"
                }
                
                //校验通过
                else {
                    // 保存一条新笔记
                    self.viewModel.editItem(item: noteModel)
                    
                    //关闭弹窗
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            
        }) {
            Text("完成")
                .font(.system(size: 17))
        }
    }
    
    //书名
    
    func titleView() ->  some View{
        TextField("本の名を入力して下さい！", text: viewModel.isAdd ? $viewModel.title : $noteModel.title)
            .padding()
    }
    
    //内容
    
    func contentView()  -> some View{
        ZStack (alignment: .topLeading){
            TextEditor(text: viewModel.isAdd ? $viewModel.content : $noteModel.content)
                .font(.system(size:17))
                .padding()
            if viewModel.isAdd ? (viewModel.content.isEmpty) : (noteModel.content.isEmpty){
                Text("入力して下さい")
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(20)
            }
        }
    }
    
    //获取时间
    
    func getCurrentTime() -> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY.MM.dd"
        //return dateformatter.string(from: ())
        return ""
    }
    
    //判断
    func isNull(text:String) -> Bool{
        if text == ""{
            return true
        }
        return false
    }
}

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView(noteModel: NoteModel(writeTime: "", title: "", content: "")).environmentObject(ViewModel())
    }
}
