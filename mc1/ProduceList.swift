//
//  ProduceList.swift
//  mc1
//
//  Created by Jefry Gunawan on 04/04/23.
//

import SwiftUI

struct ProduceList: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical){
                // Fruits
                VStack() {
                    Text("Fruits")
                        .font(.title)
                        .fontWeight(.bold)                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                ScrollView(.horizontal){
                    HStack{
                        
                    }
                }
                
                //Vegetables
            }
            .navigationTitle("All Produce")
        }
    }
}

struct ProduceList_Previews: PreviewProvider {
    static var previews: some View {
        ProduceList()
    }
}
