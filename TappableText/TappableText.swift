//
//  ContentView2.swift
//  TestTappableText
//
//  Created by Ivan Lvov on 28.02.2023.
//

import SwiftUI

struct TappableText: View {
    @Binding var selectedWord: String
    let text: String
    
    private let splitText: [String]
    private let count: Int
    
    init(selectedWord: Binding<String>, text: String) {
        self.text = text
        self.splitText = text.split(separator: " ").map { "\($0) " }
        self.count = splitText.count
        self._selectedWord = selectedWord
    }
    
    var preBody: some View {
        ForEach(self.splitText.indices) { index in
            Text(splitText[index])
                .background(
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.blue)
                        .opacity(splitText[index] == selectedWord ? 1 : 0)
                )
                .foregroundColor(splitText[index] == selectedWord ? .white : .black)
                .onTapGesture {
                    if self.selectedWord == splitText[index]{
                        self.selectedWord = ""
                    } else{
                        self.selectedWord = splitText[index]
                    }
                }
            
        }
    }
    
    @State private var height: CGFloat = 0
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    self.zStackViews(geometry)
                }
                .background(calculateHeight($height))
            }
        }
        .frame(height: height)
    }
    
    // Determine the alignment of every view in the ZStack
    func zStackViews(_ geometry: GeometryProxy) -> some View {
        // These are used to track the current horizontal and vertical position
        // in the ZStack. As a new text or link is added, horizontal is decreased.
        // When a new line is required, vertical is decreased & horizontal is reset to 0.
        var horizontal: CGFloat = 0
        var vertical: CGFloat = 0
        
        // Determine the alignment for the view at the given index
        func renderView() -> some View {
            let numberOfViewsInContent: Int = count
            let view: AnyView = AnyView( preBody )
            var numberOfViewsRendered = 0
            
            let splitText = splitText
            
            // Note that these alignment guides can get called multiple times per view
            // since ContentText returns a ForEach
            return view
                .alignmentGuide(.leading, computeValue: { dimension in
                    let hasParagraph = splitText[numberOfViewsRendered].contains("\n")
                    
                    numberOfViewsRendered += 1
                    let viewShouldBePlacedOnNextLine = geometry.size.width < -1 * (horizontal - dimension.width)

                    if viewShouldBePlacedOnNextLine{
                        // Push view to next line
                        vertical -= dimension.height
                        
                        horizontal = -dimension.width
                        
                        return 0
                    }
                    
                    if hasParagraph{
                        // Push view to next line
                        vertical -= dimension.height
                        
                        horizontal = 0
                        
                        return 0
                    }
                    
                    
                    let result = horizontal
                    
                    // Set horizontal to the end of the current view
                    horizontal -= dimension.width
                    
                    
                    return result
                })
                .alignmentGuide(.top, computeValue: { _ in
                    let result = vertical
                    
                    // if this is the last view, reset everything
                    let isLastView = numberOfViewsRendered == numberOfViewsInContent
                    
                    if isLastView {
                        vertical = 0
                        horizontal = 0
                        numberOfViewsRendered = 0
                    }
                    
                    return result
                })
                
        }
        
        return renderView()
    }
    
    // Determine the height of the view containing our combined Text and Link views
    func calculateHeight(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry -> Color in
            DispatchQueue.main.async {
                binding.wrappedValue = geometry.frame(in: .local).height
            }
            
            return .clear
        }
    }
    

}

struct ContentView2_Previews: PreviewProvider {
    
    static var previews: some View {
        TappableText(selectedWord: .constant(""), text: exampleText)
            .padding()
            .edgesIgnoringSafeArea(.all)
    }
}
