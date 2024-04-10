//
//  CameraView.swift
//  NutriGenie
//
//  Created by simge on 9.03.2024.
//

import SwiftUI
import AVFoundation

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

class CameraViewControllerWrapper: UIViewController, AVCapturePhotoCaptureDelegate {
    var tabBarControllerDelegate: UITabBarControllerDelegate?
    private let captureSession = AVCaptureSession()
    private let photoOutput = AVCapturePhotoOutput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access back camera!")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(input)
            captureSession.addOutput(photoOutput)
        } catch let error {
            print("Error Unable to initialize back camera: \(error.localizedDescription)")
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        
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
