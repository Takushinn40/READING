//
//  ContentView.swift
//  HappyReading
//
//  Created by cmStudent on 2023/02/03.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                if  viewModel.noteModels.count == 0 {
                    noDataView()
                    
                } else {
                    VStack {
                        noteListView()
                    }
                }
                newBtnView()
            }
            .navigationBarTitle("Happy Reading", displayMode: .inline)
        }
        .sheet(isPresented: $viewModel.showNewNoteView) {
            NewNoteView(noteModel: NoteModel(writeTime: "", title: "", content: ""))
        }
    }
    
    func noDataView() -> some View{
        VStack(alignment: .center, spacing: 20){
            Image("honn")
                .resizable()
                .scaleEffect()
                .frame(width:120)
            Text("ようこそ！好きな本を追加して下さい！")
                .font(.system(size: 17))
                .bold()
                .foregroundColor(.pink)
        }
    }
    
    //追加新书
    func newBtnView() -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.viewModel.isAdd = true
                    self.viewModel.writeTime = viewModel.getCurrentTime()
                    self.viewModel.title = ""
                    self.viewModel.content = ""
                    self.viewModel.showNewNoteView = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.bottom, 32)
        .padding(.trailing, 32)
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    func noteListView() -> some View {
        List {
            ForEach(viewModel.noteModels) { noteItem in
                NoteListRow(itemId: noteItem.id)
            }
        }
        .listStyle(InsetListStyle())
    }
    
    struct NoteListRow :View {
        @EnvironmentObject var viewModel: ViewModel
        
        // 获得项目唯一ID
        var itemId: UUID
        
        // 从模型类中找ID
        var item: NoteModel? {
            return viewModel.getItemById(itemId: itemId)
        }
        
        var body: some View {
            HStack {
                
                //  画面转移
                NavigationLink(destination: Timer()){

                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(item?.writeTime ?? "")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            Text(item?.title ?? "")
                                .font(.system(size: 17))
                                .foregroundColor(.black)
                            Text(item?.content ?? "")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
                
                Spacer()
                
                // 更多操作
                Button(action: {
                    
                    //点击编辑
                    self.viewModel.isAdd = false
                    self.viewModel.showEditNoteView = true
                    
                    viewModel.showActionSheet = true
                }) {
                    Image(systemName: "ellipsis")
                        .frame(width: 30, height: 30, alignment: .center)
                        .foregroundColor(.gray)
                        .font(.system(size: 23))
                }
                .buttonStyle(BorderedButtonStyle())
            }
            .sheet(isPresented: $viewModel.showEditNoteView) {
                NewNoteView(noteModel: self.item ?? NoteModel(writeTime: "", title: "", content: ""))
            }
            
            // 删除笔记
            .actionSheet(isPresented: self.$viewModel.showActionSheet) {
                ActionSheet(
                    title: Text("もこの本趣味ないですか？"),
                    message: nil,
                    buttons: [
                        .destructive(Text("DELETE"), action: {
                            self.viewModel.deleteItem(itemId: itemId)
                        }),
                        .cancel(Text("CANCEL")),
                    ])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews : some View {
        ContentView().environmentObject(ViewModel())
    }
}
