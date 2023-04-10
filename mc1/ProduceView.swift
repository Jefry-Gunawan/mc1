//
//  SwiftUIView.swift
//  mc1
//
//  Created by Jefry Gunawan on 06/04/23.
//

import SwiftUI

struct ProduceView: View {
    var produces: String = "Apple"
    
    init(produce: String) {
        self.produces = produce
    }
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Spacer()
                    VStack{
                        Image(produces)
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("Unripe")
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    VStack{
                        Image(produces)
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("Ripe")
                            .fontWeight(.semibold)
                    }
                    Spacer()
                    VStack{
                        Image(produces)
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text("Overripe")
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
                Spacer()
                VStack{
                    Image(produces)
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                Spacer()
                VStack(alignment: .leading){
                    Text("• Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                    Text("• Curabitur condimentum odio nec congue vestibulum.")
                    Text("• Donec non felis commodo mauris dictum ornare.")
                    Text("• Pellentesque varius est non pulvinar suscipit.")
                    Text("• Nam euismod eros fringilla ante tristique tincidunt.")
                }
                Spacer()
                VStack(alignment: .leading){
                    Text("• Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                    Text("• Curabitur condimentum odio nec congue vestibulum.")
                    Text("• Donec non felis commodo mauris dictum ornare.")
                    Text("• Pellentesque varius est non pulvinar suscipit.")
                    Text("• Nam euismod eros fringilla ante tristique tincidunt.")
                }
                Spacer()
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 15)
        .navigationBarTitle(produces, displayMode: .inline)
    }
}

struct ProduceView_Previews: PreviewProvider {
    static var previews: some View {
        ProduceView(produce: "Apple")
    }
}
