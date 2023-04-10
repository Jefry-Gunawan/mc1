//
//  FruitsList.swift
//  mc1
//
//  Created by Jefry Gunawan on 06/04/23.
//

import SwiftUI

struct MoreProduceList: View {
    var data: [String] = ["Apple", "Banana", "Orange", "Papaya", "Watermelon"]
    
    init(data: [String]) {
        self.data = data
    }
    
    var body: some View {
        List{
            ForEach(data, id: \.self) { data in
                NavigationLink(destination: ProduceView(produce: data)) {
                    HStack{
                        Image(data)
                            .resizable()
                            .frame(width: 80, height: 80)
                        VStack(alignment: .leading){
                            Text(data)
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.bottom, 0.1)
                            Text("This is an \(data)")
                                .font(.body)
                        }
                        .padding(.horizontal, 10)
                    }
                }
            }
        }
        .navigationBarTitle("More", displayMode: .inline)
    }
}

struct MoreProduceList_Previews: PreviewProvider {
    static var previews: some View {
        MoreProduceList(data: ["Apple", "Banana", "Orange", "Papaya", "Watermelon"])
    }
}
