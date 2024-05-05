//
//  CameraView.swift
//  NutriGenie
//
//  Created by simge on 9.03.2024.
//

import SwiftUI
import AVFoundation
import UIKit
import TensorFlowLite

struct CameraViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CameraViewControllerWrapper()
        controller.tabBarControllerDelegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, UITabBarControllerDelegate {
    }
}

class CameraViewControllerWrapper: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var tabBarControllerDelegate: UITabBarControllerDelegate?
    private let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    private var classifier: Classifier?
    override func viewDidLoad() {
        super.viewDidLoad()
        classifier = Classifier(modelPath: "model_unquant.tflite", labelsPath: "labels.txt")
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access back camera!")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera) // Kameradan gelen veriyi işlemek için giriş nesnesi oluştur
            captureSession.addInput(input) // Oluşturulan girişi oturuma ekle
            captureSession.addOutput(videoOutput) // Video çıktısını oturuma ekle
            
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            videoOutput.alwaysDiscardsLateVideoFrames = true // Geciken video karelerini daima yok say
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) // Video önizlemesi için bir katman oluştur
            previewLayer.videoGravity = .resizeAspectFill // Video görüntüsünün boyutlandırmasını ayarla
            previewLayer.frame = view.bounds // Önizleme katmanının boyutunu ayarla
            view.layer.addSublayer(previewLayer) // Önizleme katmanını görünümün katmanlarına ekle
        } catch let error {
            print("Error Unable to initialize back camera: \(error.localizedDescription)")
        }
        
        DispatchQueue.global().async {
            self.captureSession.startRunning()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.delegate = tabBarControllerDelegate
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // Görüntü verisi geldiğinde çağrılacak olan fonksiyon
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        if let result = classifier?.classify(pixelBuffer: imageBuffer) {
            DispatchQueue.main.async {
                print("Sınıflandırma sonucu: \(result)")
            }
        }
    }
}

struct CameraView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                CameraViewController()
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    NavigationLink(destination: RecipesView(viewModel: RecipeViewModel())) {
                        Image(systemName: "wand.and.stars.inverse")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.black)
                            .padding()
                            .background(.white.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .padding(.bottom, 24)
                }
            }
            .navigationBarItems(
                leading:
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                                .padding()
                                .background(.white.opacity(0.6))
                                .clipShape(Circle())
                        }
                        .padding(.top, 24)
                        Spacer()
                    },
                trailing:
                    HStack {
                        Text("Recipe Scanner")
                            .foregroundColor(.white)
                            .bold()
                            .padding(.top, 24)
                            .padding(.trailing, 50)
                        Button(action: {
                            print("bolt slash")
                        }) {
                            Image(systemName: "bolt.slash")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                                .padding()
                                .background(.white.opacity(0.6))
                                .clipShape(Circle())
                        }
                        .padding(.top, 24)
                    }
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    CameraView()
}
