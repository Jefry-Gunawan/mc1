//
//  ContentView.swift
//  mc1
//
//  Created by Jefry Gunawan on 03/04/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        TabView{
            CameraView()
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Scan")
                }
            
            Text("Hello World")
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Produce List")
                }
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CameraView: View {
    @StateObject var camera = CameraModel()
    var body: some View{
        ZStack{
            CameraPreview(camera: camera)
            
            VStack{
                Spacer()
                
            }
        }
        .onAppear {
            camera.Check()
        }
    }
}

// Camera Model
class CameraModel: ObservableObject{
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview : AVCaptureVideoPreviewLayer!
    
    func Check(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {
                (status) in
                
                if status{
                    self.setUp()
                }
            }
        case .denied:
            self.alert.toggle()
            return
        default:
            return
        }
    }
    
    func setUp(){
        do{
            self.session.beginConfiguration()
            
            let device = AVCaptureDevice.default(for: .video)
            
            let input = try AVCaptureDeviceInput(device: device!)
            
            if self.session.canAddInput(input){
                self.session.addInput(input)
            }
            
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            self.session.commitConfiguration()
        }
        catch{
            print(error.localizedDescription)
        }
    }
}

struct CameraPreview : UIViewRepresentable{
    @ObservedObject var camera : CameraModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIViewType(frame: UIScreen.main.bounds)
        
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        // Add a rectangle layer to show the viewfinder
//        let roundedRectLayer = CAShapeLayer()
//        roundedRectLayer.strokeColor = UIColor.white.cgColor
//        roundedRectLayer.lineWidth = 8
//        roundedRectLayer.opacity = 0.75
//        roundedRectLayer.fillColor = UIColor.clear.cgColor
//        let cornerRadius: CGFloat = 20
//        let path = UIBezierPath(roundedRect: CGRect(x: view.frame.midX - 125, y: view.frame.midY - 175, width: 250, height: 250), cornerRadius: cornerRadius)
//        roundedRectLayer.path = path.cgPath
//        view.layer.addSublayer(roundedRectLayer)
        
        camera.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        camera.preview.frame = uiView.frame
    }
}
