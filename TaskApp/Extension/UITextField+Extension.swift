//
//  FirstResponderTextField.swift
//  TaskApp
//
//  Created by Togay Aytemiz on 30.04.2021.
//

import SwiftUI
import Foundation



struct FirstResponderUITextField: View {
    
    @State var text: String = ""


    var body: some View {
        HStack {
            TextView(text: $text) { // Configuring the text field
                $0.font = UIFont(name: "HelveticaNeue", size: 16)
                $0.isScrollEnabled = true
                $0.isEditable = true
                $0.isUserInteractionEnabled = true
                $0.backgroundColor = UIColor(white: 0.0, alpha: 0.00)
                $0.textColor = UIColor(Color(.red))
                $0.autocorrectionType = .no
            }
            
            onCommit: { // Detecting the commit
                print("Committed with text: " + text)
            }
            
            .onChange(of: text) { value in // The native way to detect changes of a State
                print("text now: " + text)

            }
        }
    }
}


struct TextView: UIViewRepresentable {
    @Binding var text: String


    var configurate: (UITextView) -> ()
    var onCommit: ()->()

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let myTextView = UITextView(frame: .infinite)
        configurate(myTextView) // Forwarding the configuring step
        myTextView.delegate = context.coordinator
        
        
        return myTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        uiView.becomeFirstResponder()
        context.coordinator.becameFirstResponder = true
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        var becameFirstResponder = false


        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if (text == "\n") {
                textView.resignFirstResponder()
                parent.onCommit() // Execute the passed `onCommit` method here
            }
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text // Update the actual variable
        }
    }
}





struct FirstResponderTextField : UIViewRepresentable {
    
    @Binding var text: String
    let placeholder: String
    
    class Coordinator: NSObject, UITextFieldDelegate{
        
        @Binding var text: String
        var becameFirstResponder = false
        
        init(text: Binding<String>) {
            self._text = text
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            text = textField.text ?? ""
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .sentences
        textField.returnKeyType = .done
//        textField.textColor = UIColor.black
        

    
        return textField
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if !context.coordinator.becameFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.becameFirstResponder = true
        }
    }
    
}


// UITEXTFIELD'ın kullanıldığı yerlerdeki font için kullanılmaktadır.
extension UIFont {
    class func rounded(ofSize size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
        let font: UIFont
        
        if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
            font = UIFont(descriptor: descriptor, size: size)
        } else {
            font = systemFont
        }
        return font
    }
}
