//
//  ModalSheets.swift
//  mc1
//
//  Created by Jefry Gunawan on 04/04/23.
//

import SwiftUI

struct ModalSheets: View {
    var body: some View {
        ScrollView{
            VStack{
                
            }
            VStack{
                Text("Meat")
                    .font(.title)
                    .fontWeight(.bold)
                Image("Cow")
                    .resizable()
                    .frame(width: 150, height: 150)
                VStack(alignment: .leading){
                    Text("• Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                    Text("• Curabitur condimentum odio nec congue vestibulum.")
                    Text("• Donec non felis commodo mauris dictum ornare.")
                    Text("• Pellentesque varius est non pulvinar suscipit.")
                    Text("• Nam euismod eros fringilla ante tristique tincidunt.")
                    Text("• Nullam quis nunc vel ante bibendum rhoncus id a elit.")
                }
                
                HStack{
                    Spacer()
                    VStack{
                        Image("Cow")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("Bad")
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    VStack{
                        Image("Cow")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("Okay")
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    VStack{
                        Image("Cow")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("Good")
                            .fontWeight(.semibold)
                    }
                    Spacer()
                }
                .padding()
                Spacer()
                VStack(alignment: .leading){
                    Text("• Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                    Text("• Curabitur condimentum odio nec congue vestibulum.")
                    Text("• Donec non felis commodo mauris dictum ornare.")
                    Text("• Pellentesque varius est non pulvinar suscipit.")
                    Text("• Nam euismod eros fringilla ante tristique tincidunt.")
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 15)
        .ignoresSafeArea(.container, edges: [.bottom])
    }
}

struct TextView: UIViewRepresentable {
    var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        textView.textAlignment = .justified
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

struct ModalSheets_Previews: PreviewProvider {
    static var previews: some View {
        ModalSheets()
    }
}
