//
//  ProduceList.swift
//  mc1
//
//  Created by Jefry Gunawan on 04/04/23.
//

import SwiftUI

struct ProduceList: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var searchText = ""
    var fruitsData = ["Apple", "Banana", "Orange", "Papaya", "Watermelon"]
    var vegetablesData = ["Cabbage", "Eggplant", "Carrot"]
    var meatsData = ["Chicken", "Cow"]
    
    var body: some View {
        NavigationStack {
            VStack{
                if searchText.isEmpty{
                    ScrollView{
                        // Fruits
                        VStack() {
                            HStack{
                                Text("Fruits")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                NavigationLink(destination: MoreProduceList(data: fruitsData), label: {
                                    Text("See More")
                                })
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        
                        ScrollView(.horizontal){
                            HStack{
                                if colorScheme == .dark {
                                    ForEach(fruitsData, id: \.self) { fruitsData in
                                        VStack{
                                            NavigationLink(destination: ProduceView(produce: fruitsData)) {
                                                Image(fruitsData)
                                                    .resizable()
                                                    .frame(width: 60, height: 60)
                                                    .padding()
                                                    .clipShape(Circle())
                                                    .overlay(Circle().stroke(Color.white, lineWidth: 1).opacity(0.1))
                                            }
                                            Text(fruitsData)
                                                .font(.body)
                                                .fontWeight(.bold)
                                        }
                                    }
                                } else {
                                    ForEach(fruitsData, id: \.self) { fruitsData in
                                        VStack{
                                            NavigationLink(destination: ProduceView(produce: fruitsData)) {
                                                Image(fruitsData)
                                                    .resizable()
                                                    .frame(width: 60, height: 60)
                                                    .padding()
                                                    .clipShape(Circle())
                                                    .overlay(Circle().stroke(Color.black, lineWidth: 1).opacity(0.1))
                                            }
                                            Text(fruitsData)
                                                .font(.body)
                                                .fontWeight(.bold)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 15)
                            .padding(.bottom, 20)
                        }
                        
                        //Vegetables
                        VStack() {
                            HStack{
                                Text("Vegetables")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                NavigationLink(destination: MoreProduceList(data: vegetablesData), label: {
                                    Text("See More")
                                })
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        
                        ScrollView(.horizontal){
                            HStack{
                                if colorScheme == .dark {
                                    ForEach(vegetablesData, id: \.self) { vegetablesData in
                                        VStack{
                                            NavigationLink(destination: ProduceView(produce: vegetablesData)) {
                                                Image(vegetablesData)
                                                    .resizable()
                                                    .frame(width: 60, height: 60)
                                                    .padding()
                                                    .clipShape(Circle())
                                                    .overlay(Circle().stroke(Color.white, lineWidth: 1).opacity(0.1))
                                            }
                                            Text(vegetablesData)
                                                .font(.body)
                                                .fontWeight(.bold)
                                        }
                                    }
                                } else {
                                    ForEach(vegetablesData, id: \.self) { vegetablesData in
                                        VStack{
                                            NavigationLink(destination: ProduceView(produce: vegetablesData)) {
                                                Image(vegetablesData)
                                                    .resizable()
                                                    .frame(width: 60, height: 60)
                                                    .padding()
                                                    .clipShape(Circle())
                                                    .overlay(Circle().stroke(Color.black, lineWidth: 1).opacity(0.1))
                                            }
                                            Text(vegetablesData)
                                                .font(.body)
                                                .fontWeight(.bold)
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 15)
                            .padding(.bottom, 20)
                        }
                        
                        // Meat
                        VStack() {
                            HStack{
                                Text("Meat")
                                    .font(.title)
                                    .fontWeight(.bold)
                                Spacer()
                                NavigationLink(destination: MoreProduceList(data: meatsData), label: {
                                    Text("See More")
                                })
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        
                        ScrollView(.horizontal){
                            HStack{
                                if colorScheme == .dark {
                                    ForEach(meatsData, id: \.self) { meatsData in
                                        VStack{
                                            NavigationLink(destination: ProduceView(produce: meatsData)) {
                                                Image(meatsData)
                                                    .resizable()
                                                    .frame(width: 60, height: 60)
                                                    .padding()
                                                    .clipShape(Circle())
                                                    .overlay(Circle().stroke(Color.white, lineWidth: 1).opacity(0.1))
                                            }
                                            Text(meatsData)
                                                .font(.body)
                                                .fontWeight(.bold)
                                        }
                                    }
                                } else {
                                    ForEach(meatsData, id: \.self) { meatsData in
                                        VStack{
                                            NavigationLink(destination: ProduceView(produce: meatsData)) {
                                                Image(meatsData)
                                                    .resizable()
                                                    .frame(width: 60, height: 60)
                                                    .padding()
                                                    .clipShape(Circle())
                                                    .overlay(Circle().stroke(Color.black, lineWidth: 1).opacity(0.1))
                                            }
                                            Text(meatsData)
                                                .font(.body)
                                                .fontWeight(.bold)
                                        }
                                    }
                                }
                            }
                            
                        }
                        .padding(.horizontal, 15)
                        .padding(.bottom, 20)
                    }
                } else {
                    List{
                        ForEach(searchResultsFruits, id: \.self) { name in
                            NavigationLink(destination: ProduceView(produce: name)) {
                                HStack{
                                    Image(name)
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                    VStack(alignment: .leading){
                                        Text(name)
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .padding(.bottom, 0.1)
                                        Text("This is an \(name)")
                                            .font(.body)
                                    }
                                    .padding(.horizontal, 10)
                                }
                            }
                        }
                        
                        ForEach(searchResultsVegetables, id: \.self) { name in
                            NavigationLink(destination: ProduceView(produce: name)) {
                                HStack{
                                    Image(name)
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                    VStack(alignment: .leading){
                                        Text(name)
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .padding(.bottom, 0.1)
                                        Text("This is an \(name)")
                                            .font(.body)
                                    }
                                    .padding(.horizontal, 10)
                                }
                            }
                        }
                        
                        ForEach(searchResultsMeats, id: \.self) { name in
                            NavigationLink(destination: ProduceView(produce: name)) {
                                HStack{
                                    Image(name)
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                    VStack(alignment: .leading){
                                        Text(name)
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .padding(.bottom, 0.1)
                                        Text("This is an \(name)")
                                            .font(.body)
                                    }
                                    .padding(.horizontal, 10)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("All Produce")
            .searchable(text: $searchText)
        }
    }
    
    var searchResultsFruits: [String] {
        if searchText.isEmpty {
            return fruitsData
        } else {
            return fruitsData.filter { $0.lowercased().contains(searchText) }
        }
    }
    
    var searchResultsVegetables: [String] {
        if searchText.isEmpty {
            return vegetablesData
        } else {
            return vegetablesData.filter { $0.lowercased().contains(searchText) }
        }
    }
    
    var searchResultsMeats: [String] {
        if searchText.isEmpty {
            return meatsData
        } else {
            return meatsData.filter { $0.lowercased().contains(searchText) }
        }
    }
}

struct ProduceList_Previews: PreviewProvider {
    static var previews: some View {
        ProduceList()
    }
}
