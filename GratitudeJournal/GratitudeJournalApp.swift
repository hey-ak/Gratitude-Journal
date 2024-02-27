
import SwiftUI

struct ContentView: View {
    
    @State var text: String = "sdfsfsfsdfs"
    @State var placeHolder = "Type text here..."
    @State var isImagePickerPresented = false
    @State var selectedImage:UIImage
    
    var body: some View {
        GeometryReader { geometry in // Use GeometryReader to dynamically adjust size
            
            VStack {
                Spacer()
                    .frame(height: geometry.size.height * 0.02, alignment: .center)

                
                HStack {
                    Text("Write something you're grateful \nfor")
                        .font(.system(size: 25, weight: .semibold, design: .default))
                        .padding(.leading, 20)
                    Spacer(minLength: 0)
                }
                Spacer()
                    .frame(height: geometry.size.height * 0.015, alignment: .center)

                VStack {
                    TextView(text: $text, placeholder: $placeHolder)
                        .frame(height: 200)
                        .background(Color.blue.opacity(0.1))
                        .padding(20)
                        .cornerRadius(10) // Apply corner radius directly to TextView
                        .clipped()
                }
                .foregroundColor(.blue.opacity(0.1))
                
                Spacer()
                    .frame(height: geometry.size.height * 0.015, alignment: .center)
                
                VStack {
                    Button(action: {
                        self.isImagePickerPresented = true
                    }) {
                        ZStack {
                            
                        
                            Image(uiImage: selectedImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black.opacity(0.5), lineWidth: 1) // Apply border
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2) // Apply shadow
                        }
                    }
                    .buttonStyle(PlainButtonStyle()) // Use plain button style to remove default button style
                    .frame(width: UIScreen.main.bounds.width - 40, height: 200) // Adjust frame here
                    .padding(20)
                }
                .background(Color.clear) // Set the background color of VStack to clear
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
               
                
                Spacer()
                
                Button(action: {
                    saveData()
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .frame(height: 50)
                .padding()
            }
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePickerView(sourceType: .photoLibrary) { image in
                    self.selectedImage = image
                }
            }
        }
    }
    
    private func saveData() {
        let id = ItemDataManager.shared.generateUniqueID()
        let item = Item(id: id, title: text, date: Date(), imageURL: "",image: selectedImage)
        ItemDataManager.shared.addItem(item)
        self.selectedImage = UIImage(named: "add-image")!
        self.text = ""
    }
    
}
