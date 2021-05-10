//
//  AutoResizeDeneme.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 2.05.2021.
//

import SwiftUI
import Foundation

//struct AutoResizableTextFieldExtension: View {
//    
//    @EnvironmentObject var obj: observed
//    
//    @State private var textField: String = ""
//    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
//    @AppStorage("appColor1") private var AppColor1: String = "Color1A"
//    
//    // MARK: BODY
//    var body: some View {
//        VStack{
//
//            
//            // MARK: MAIN SEARCH BAR
//            HStack {
//                
//
//                    // SEARCH BAR ------ ICON + YAZI + EMPTY BUTTON
//                    HStack{
//                        
//                        Image(systemName: "magnifyingglass")
//                            .font(.system(size: 18, weight: .semibold, design: .rounded))
//                            .foregroundColor(Color(AppColor1))
//                            .padding(.leading, 4)
//                        
//                        ZStack(alignment: .leading){
//                            if textField == "" {
//                                Text("Görev ara...")
//                                    .font(.system(.subheadline, design: .rounded))
//                                    .foregroundColor(!isDarkMode ? Color.gray : .white.opacity(0.6))
//                                    .padding(.leading, 5)
//
//                            }
//                            
//                            MultiTextField(text: $textField, color: Color(AppColor1))
//                                .animation(.easeIn)
//                        }
//                        
//                        Spacer()
//                        
//                        Group{
//                        if textField != "" {
//                            Button(action: {
//                                textField = ""
//                                //haptics.impactOccurred()
//                            }, label: {
//                                Image(systemName: "xmark.circle.fill")
//                                    .font(.headline)
//                                    .foregroundColor(Color.gray)
//                                    .padding(.trailing, 4)
//                                
//                            })
//                        }
//                        }
//                    }
//                    .frame(height: self.obj.size)
//                    .padding(5)
//                    .background( isDarkMode ? Color.secondary : Color(UIColor.systemGray6))
//                    .cornerRadius(12)
//                
//                
//                
//                Spacer()
//
//                
//                // VAZGEÇ BUTONU
//                
//                Button(action: {
////                    haptics.impactOccurred()
////                    presentationMode.wrappedValue.dismiss()
//                }, label: {
//                    Text("Vazgeç")
//                        .foregroundColor(Color(AppColor1))
//                })
//
//            }
//
//            
//        }.padding()
//    }
//}
//
//
//
//struct AutoResizeDeneme_Previews: PreviewProvider {
//    static var previews: some View {
//        AutoResizableTextFieldExtension()
//            .environmentObject(observed())
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}


struct MultiTextField: UIViewRepresentable {
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("appColor1") private var AppColor1: String = "Color1A"
    
    @Binding var text: String
    var color : Color = .red

    //var onCommit: ()->()

    func makeCoordinator() -> Coordinator {
        return MultiTextField.Coordinator(parent1: self)
    }
    
    
    
    @EnvironmentObject var obj: observed
    
    func makeUIView(context: UIViewRepresentableContext<MultiTextField>) -> UITextView {
        
        let view = UITextView()
        view.font = .rounded(ofSize: 18, weight: .semibold)
        view.text = "Type Something"
        view.textColor = UIColor(isDarkMode ? Color.white : Color.black)
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        view.tintColor = UIColor(color)
        view.autocorrectionType = .no
        view.returnKeyType = .done
        view.keyboardAppearance = isDarkMode ? .dark : .default

        
        self.obj.size = view.contentSize.height
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        view.isPagingEnabled = false
        
        return view
        
        
        
        
        //                                $0.textColor = UIColor(isDarkMode ? Color.white : Color.primary)
        //                                $0.tintColor = UIColor(Color(AppColor1))
    }
    
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<MultiTextField>) {
        uiView.text = text
        
        // first responder olması istenmiyorsa aşağıdakileri kapa
        uiView.becomeFirstResponder()
        context.coordinator.becameFirstResponder = true
        // --------------------
    }
    
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        
        var color : Color = .red

        
        var parent: MultiTextField
        
        // first responder olması istenmiyorsa aşağıdaki kodu kapa
        var becameFirstResponder = false
        // ------------------
        
        init(parent1: MultiTextField) {
            parent = parent1
        }
        
//        func textViewDidBeginEditing(_ textView: UITextView) {
//            textView.text = ""
//            textView.textColor = UIColor(color)
//        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
            self.parent.obj.size = textView.contentSize.height

        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if (text == "\n") {
                textView.resignFirstResponder()
                //parent.onCommit() // Execute the passed `onCommit` method here
            }
            return true
        }
        
    }
    
}

class observed: ObservableObject{
    @Published var size: CGFloat = 0
}
