//
//  FilterView.swift
//  Hookah Mixes
//
//  Created by Maksim Kosharny on 09.04.2023.
//

import SwiftUI

struct FilterView: View {
    
    
    @ObservedObject var viewModel = FilterViewModel()
    
    @State private var collectionsInfo: CollectionCellInfo?
    @Binding var isFiltered: Bool
    @Binding  var showFilter: Bool
    
//    @State private var showAlert = false
//    @State var selectedOption: String
    
    @State private var hidenFilter = true
    @State private var markTobacco = false
    @State private var sourSweet = false
    @State private var country = false
    @State private var strenght = false
    @State private var heatResponse = false
    @State private var selectedMarkTobacco = "Марка табака"
    @State private var selectedStrenght = "Крепкость"
    let markTabakoFilter = ["Must Have", "Azure", "Burn"]
    let strenghtFilter = ["Крепкий", "Средний", "Легкий"]
    
    var body: some View {
        VStack {
            if hidenFilter {
                optionMenu
            }
             
            if isFiltered {
                collectionCellFilter
            }
                
            
//            if heatResponse {
//                optionMenu
//            }
        }
        .background(hidenFilter ? Color("FooterColor") : Color(.clear))
    }
    
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView( isFiltered: .constant(false), showFilter: .constant(true))
    }
}

extension FilterView {
    
    var optionMenu: some View {
        VStack {
            HStack {
                Spacer()
                Text("Фильтры")
                    .font(.title)
                    .foregroundColor(Color("TextFooterColor"))
            }
            .padding()
            
            Divider()
                .frame(width: 380)
                .overlay(Color("TextFooterColor"))
            
            Button {
                // actions...
                withAnimation(.easeIn(duration: 0.3)) {
                    self.markTobacco.toggle()
                }
            } label: {
                VStack {
                    HStack {
                        Text("Марка табака")
                            .font(.title2)
                            .foregroundColor(Color("TextFooterColor"))
                        Spacer()
                        
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.title2)
                            .foregroundColor(Color("TextFooterColor"))
                    }
                    .padding()
                    
                    Divider()
                        .frame(width: 380)
                        .overlay(Color("TextFooterColor"))
                    
                }
            }
            
            if markTobacco {
                //                OptionMenuView(selectedOption: $selectedMarkTobacco, options: markTabakoFilter)
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.gray)
                        .frame(width: 380, height: 50)
                    Menu(selectedMarkTobacco) {
                        ForEach(markTabakoFilter, id: \.self) { option in
                            Button(option) {
                                self.selectedMarkTobacco = option
                                viewModel.fetchFilterTobaccoNameNews(filterName: option)
                                self.isFiltered = true
                                self.hidenFilter = false
                            }
                        }
                    }
                }
                .foregroundColor(.white)
                .menuStyle(BorderlessButtonMenuStyle())
                .padding()
            }
            
            Button {
                // actions...
                withAnimation(.easeIn(duration: 0.3)) {
                    self.sourSweet.toggle()
                }
            } label: {
                VStack {
                    HStack {
                        Text("Кислый/сладкий")
                            .font(.title2)
                            .foregroundColor(Color("TextFooterColor"))
                        Spacer()
                        
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.title2)
                            .foregroundColor(Color("TextFooterColor"))
                    }
                    .padding()
                    
                    Divider()
                        .frame(width: 380)
                        .overlay(Color("TextFooterColor"))
                    
                    
                }
            }
            
            //            if sourSweet {
            //                optionMenu
            //            }
            
            Button {
                // actions...
                withAnimation(.easeIn(duration: 0.3)) {
                    self.country.toggle()
                }
            } label: {
                VStack {
                    HStack {
                        Text("Страна производства")
                            .font(.title2)
                            .foregroundColor(Color("TextFooterColor"))
                        Spacer()
                        
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.title2)
                            .foregroundColor(Color("TextFooterColor"))
                    }
                    .padding()
                    
                    Divider()
                        .frame(width: 380)
                        .overlay(Color("TextFooterColor"))
                    
                    
                }
            }
            //            if country {
            //                optionMenu
            //            }
            
            Button {
                // actions...
                withAnimation(.easeIn(duration: 0.3)) {
                    self.strenght.toggle()
                }
            } label: {
                VStack {
                    HStack {
                        Text("Крепкость")
                            .font(.title2)
                            .foregroundColor(Color("TextFooterColor"))
                        Spacer()
                        
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.title2)
                            .foregroundColor(Color("TextFooterColor"))
                    }
                    .padding()
                    
                    Divider()
                        .frame(width: 380)
                        .overlay(Color("TextFooterColor"))
                    
                    
                }
            }
            
            if strenght {
                //                OptionMenuView(selectedOption: $selectedStrenght, options: strenghtFilter)
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.gray)
                        .frame(width: 380, height: 50)
                    Menu(selectedStrenght) {
                        ForEach(strenghtFilter, id: \.self) { option in
                            Button(option) {
                                self.selectedStrenght = option
                                viewModel.fetchFilterStrenghtNews(filterName: option)
                                self.isFiltered = true
                                self.hidenFilter = false
                            }
                        }
                    }
                }
                .foregroundColor(.white)
                .menuStyle(BorderlessButtonMenuStyle())
                .padding()
            }
            
            Button {
                // actions...
                withAnimation(.easeIn(duration: 0.3)) {
                    self.heatResponse.toggle()
                }
            } label: {
                VStack {
                    HStack {
                        Text("Жарастойкость")
                            .font(.title2)
                            .foregroundColor(Color("TextFooterColor"))
                        Spacer()
                        
                        Image(systemName: "arrowtriangle.down.fill")
                            .font(.title2)
                            .foregroundColor(Color("TextFooterColor"))
                    }
                    .padding()
                    
                    Divider()
                        .frame(width: 380)
                        .overlay(Color("FooterColor"))
                    
                }
            }
            
//            Button {
//                withAnimation(.easeIn(duration: 0.3)) {
//                    self.isFiltered = true
////                    self.showFilter = false
//                }
//            } label: {
//                ZStack {
//                    RoundedRectangle(cornerRadius: 16)
//                        .foregroundColor(.gray)
//                        .frame(width: 380, height: 50)
//                    Text("Применить")
//                        .font(.title2)
//                        .foregroundColor(Color("TextFooterColor"))
//                }
//                .padding()
//            }
            
        }
    }
    
    
    var collectionCellFilter: some View {
            
//        ScrollView {
                
                
                ForEach(viewModel.tobaccoMixes) { hookah in
                    Button {
                        self.collectionsInfo = CollectionCellInfo(imageName: hookah.imageName, textLabel: hookah.textLabel, text: hookah.text ?? "", tobaccoName: hookah.tobaccoName ?? "")
                    } label: {
                        CollectionViewCell(collectionCellInfo: CollectionCellInfo(imageName: hookah.imageName, textLabel: hookah.textLabel))
                    }
                    .sheet(item: $collectionsInfo) { collectionsInfo in
                        NewsView(collectionCellInfo: collectionsInfo)
                    }
                }
//        }
//        .frame(width: 430)
//        .background(Color("Background"))
        
        
    }
}
