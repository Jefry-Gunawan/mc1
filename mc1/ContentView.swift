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
            // Untuk Camera
            CameraView()
                .ignoresSafeArea(.container, edges: [.top, .bottom])
                .safeAreaInset(edge: .top, alignment: .center, spacing: 0) {
                                Color.clear
                                    .frame(height: 0)
                                    .background(.ultraThinMaterial)
                            }
                .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                                Color.clear
                                    .frame(height: 0)
                                    .background(.thickMaterial)
                            }
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Scan")
                }
            ProduceList()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Produce List")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Untuk  mengubah color hex jadi Color Code
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

// To make rounded rectangle on specified corners
struct RoundedCorners: View {
    var color: Material = .regularMaterial
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                path.closeSubpath()
            }
            .fill(self.color)
        }
    }
}

// Camera View set ZStack and layout
struct CameraView: View {
    @StateObject var camera = CameraModel()
    @State private var isShowingSheet = false
    @State var status = "Scanning..."
    @Environment(\.colorScheme) var colorScheme
    
    @State var timeRemaining = 2
    @State var timeRemainingModal = 2
    @State var flag = true
       let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    var body: some View{
        ZStack{
            CameraPreview(camera: camera)
            
            VStack{
                Spacer()
                Button(action: {
                    self.isShowingSheet = true
                }, label: {
                    if colorScheme == .dark {
                        Text(status)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 70)
                            .foregroundColor(Color.white)
                            .background(RoundedCorners(color: .thickMaterial, tl: 20, tr: 20, bl: 0, br: 0))
                    } else {
                        Text(status)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 70)
                            .foregroundColor(Color.black)
                            .background(RoundedCorners(color: .thickMaterial, tl: 20, tr: 20, bl: 0, br: 0))
                    }
                    
                })
                .padding(.bottom, 80)
            }
            
            // Timer untuk ganti isi variable dari Scanning ke Apple
            Text("")
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else if timeRemaining == 0 {
                    status = "Apple"
                }
                if timeRemainingModal > 0 {
                    timeRemainingModal -= 1
                } else if timeRemainingModal == 0 && flag == true {
                    // flag agar is showing sheetnya nda muncul2 lagi
                    flag = false
                    isShowingSheet = true
                }
            }
        }
        .onAppear {
            camera.Check()
        }
        .sheet(isPresented: $isShowingSheet) {
            // Isi Modal Sheets
            ModalSheets()
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
        let roundedRectLayer = CAShapeLayer()
        roundedRectLayer.strokeColor = UIColor.white.cgColor
        roundedRectLayer.lineWidth = 8
        roundedRectLayer.opacity = 0.75
        roundedRectLayer.fillColor = UIColor.clear.cgColor
        let cornerRadius: CGFloat = 20
        let path = UIBezierPath(roundedRect: CGRect(x: view.frame.midX - 125, y: view.frame.midY - 175, width: 250, height: 250), cornerRadius: cornerRadius)
        roundedRectLayer.path = path.cgPath
        view.layer.addSublayer(roundedRectLayer)
        
        camera.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        camera.preview.frame = uiView.frame
    }
}
