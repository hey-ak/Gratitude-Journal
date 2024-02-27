import Foundation
import SwiftUI



extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}


struct AnimalGridItemView: View {
    let animal: Animal
    var body: some View {
        Image(animal.image)
            .resizable()
            .scaledToFit()
            .cornerRadius(12)
    }
}

struct HeadingView: View {
    var headingImage:String
    var headingText:String
    var body: some View {
        HStack {
            Image(systemName:headingImage)
                .foregroundColor(.accentColor)
                .imageScale(.large)
            
            Text(headingText)
                .font(.title3)
                .fontWeight(.bold)
            
        }
        .padding(.vertical)
    }
}









struct Animal:Codable,Identifiable {
    let id:String
    let name:String
    let headline:String
    let description:String
    let link:String
    let image:String
    let gallery:[String]
    let fact:[String]
}
extension Bundle {
    func decode <T:Codable> (_ file:String) -> T {
        //  1. Locate the json file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        // 2. Create a property for data
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        // 3. Create a decoder
        let decoder = JSONDecoder()
        
        // 4. Create a property for decoded data
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle")
        }
        // 5. Return thr ready to use data
        return loaded
        
    }
}
struct CoverImage:Codable,Identifiable {
    let id:Int
    let name:String
}

struct TextView: UIViewRepresentable {
    @Binding var text: String
    @Binding var placeholder:String
    
    func makeUIView(context: UIViewRepresentableContext<TextView>) -> UITextView {
        let textView = UIKitTextView()
        textView.textColor = .gray
        textView.delegate = context.coordinator
        textView.backgroundColor = .clear
        textView.font = .systemFont(ofSize: 14, weight: .medium)
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: UIViewRepresentableContext<TextView>) {
        textView.text = self.placeholder
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, placeholder: $placeholder)
    }
    
    final private class UIKitTextView: UITextView {
        
        override var contentSize: CGSize {
            didSet {
                invalidateIntrinsicContentSize()
            }
        }
        
        override var intrinsicContentSize: CGSize {
            CGSize(width: UIView.noIntrinsicMetric, height: UIScreen.main.bounds.height * 0.2)
        }
    }
    
    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var placeholder: Binding<String>
        
        init(text: Binding<String>,placeholder: Binding<String>) {
             self.text = text
             self.placeholder = placeholder
        }
        
        func textViewDidChange(_ textView: UITextView) {
             text.wrappedValue = textView.text
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.text == placeholder.wrappedValue {
                textView.text = ""
            }
        }
        
        func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
            if textView.text == "" {
                textView.text = placeholder.wrappedValue
            }
            return true
        }
        
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                   textView.resignFirstResponder()
                   return false
               }
               return true
        }
    }
}


struct CoverImageView: View {
    
    //MARK: - Property
    let coverImages: [CoverImage] = Bundle.main.decode("covers.json")
    //MARK: - Body
    var body: some View {
        TabView {
            ForEach(coverImages) { item in
                Image(item.name)
                    .resizable()
                .scaledToFill()
            }//: LOOP
        }
        .tabViewStyle(PageTabViewStyle())
       
    }
}

struct AnimalDetailView: View {
    var animal:Animal
    var body: some View {
            ScrollView(.vertical,showsIndicators: false) {
                
                VStack (alignment: .center,spacing: 20) {
                    // MARK: - COVER IMAGE
                    Image(animal.image)
                        .resizable()
                        .scaledToFit()
                    // MARK: - TITLE
                    Text(animal.name.uppercased())
                        .foregroundColor(.primary)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                        .padding(.vertical,8)
                        .background(
                            Color.accentColor
                                .frame(height:6)
                                .offset(y:26)
                        )
                    // MARK: - HEADLINE
                    Text(animal.headline)
                        .foregroundColor(.accentColor)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                    // MARK: - GALLERY
                    Group {
                        HeadingView(headingImage: "photo.on.rectangle.angled", headingText: "Willderness in pictures")
                        
                       // InsetGalleryView(animal: animal)
                    }
                    .padding(.horizontal)
                    
                    // MARK: - FACTS
                    Group {
                      HeadingView(headingImage: "questionmark.circle", headingText: "Did you know?")
                        //FactView(animal: animal)
                    }
                    .padding(.horizontal)
                    // MARK: - DESCRIPTION
                    Group {
                        HeadingView(headingImage: "info.circle", headingText: "All about \(animal.name)")
                        Text(animal.description)
                            .multilineTextAlignment(.leading)
                            .layoutPriority(1)
                    }
                    // MARK: - MAP
                    Group {
                        HeadingView(headingImage: "map", headingText: "National Park")
                       // InsetMapView()
                    }
                    .padding(.horizontal)
                    // MARK: - LINK
                    Group {
                      HeadingView(headingImage: "books.vertical", headingText: "Learn More")
                       // ExternalWebLinkView(animal: animal)
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("Learn about \(animal.name)")
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                print("sdfsdfsdfdsfsfsfsffsfsfsfsdfsffsf")
            }
    }
}
