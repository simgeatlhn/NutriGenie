//
//  CameraView.swift
//  NutriGenie
//
//  Created by simge on 9.03.2024.
//

import SwiftUI
import AVFoundation
import UIKit

struct CameraViewController: UIViewControllerRepresentable {
    @Binding var filteredRecipes: [Recipe]
    @Binding var scanStatus: String
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CameraViewControllerWrapper(filteredRecipes: $filteredRecipes, scanStatus: $scanStatus)
        controller.tabBarControllerDelegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, UITabBarControllerDelegate {}
}

class CameraViewControllerWrapper: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    var tabBarControllerDelegate: UITabBarControllerDelegate?
    private let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    private let imageClassifier: ImageClassifier
    @Binding var filteredRecipes: [Recipe]
    @Binding var scanStatus: String
    private var recipeViewModel = RecipeViewModel()
    
    init(filteredRecipes: Binding<[Recipe]>, scanStatus: Binding<String>) {
        self._filteredRecipes = filteredRecipes
        self._scanStatus = scanStatus
        self.imageClassifier = ImageClassifier(model: RecipeClassifier().model)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeViewModel.fetchRecipes()
        
        guard let backCamera = AVCaptureDevice.default(for: .video) else {
            print("Unable to access back camera!")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession.addInput(input)
            
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            captureSession.addOutput(videoOutput)
            
            let connection = videoOutput.connection(with: .video)
            connection?.videoOrientation = .portrait
        } catch let error {
            print("Error Unable to initialize back camera: \(error.localizedDescription)")
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.frame = view.bounds
        view.layer.addSublayer(previewLayer)
        
        startCaptureSession()
        
        // Başlangıçta scanning mesajını göster
        DispatchQueue.main.async {
            self.scanStatus = "Scanning the ingredient..."
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
        stopCaptureSession() // Stop the session when the view disappears
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        imageClassifier.classify(pixelBuffer: pixelBuffer) { result in
            if let result = result {
                print("Classified object: \(result)")
                
                self.recipeViewModel.updateFilteredRecipes(with: result)
                
                DispatchQueue.main.async {
                    self.filteredRecipes = self.recipeViewModel.filteredRecipes
                    if let recipe = self.recipeViewModel.filteredRecipes.first {
                        print("Matching recipe found: \(recipe.name)")
                        self.stopCaptureSession() // Stop the session when a matching recipe is found
                        self.scanStatus = "Ingredient detected!"
                    } else {
                        print("No matching recipe found for \(result)")
                    }
                }
            } else {
                print("Unable to classify the image.")
            }
        }
    }
    
    func startCaptureSession() {
        DispatchQueue.global().async {
            if !self.captureSession.isRunning {
                self.captureSession.startRunning()
            }
        }
    }

    
    func stopCaptureSession() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
}

struct CameraView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var filteredRecipes: [Recipe] = []
    @State private var scanStatus: String = "Scanning the ingredient..."
    @StateObject var recipeViewModel = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                CameraViewController(filteredRecipes: $filteredRecipes, scanStatus: $scanStatus)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        scanStatus = "Scanning the ingredient..."
                    }
                
                VStack {
                    Spacer()
                    Text(scanStatus)
                        .foregroundColor(.white)
                        .bold()
                        .padding(6)
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(20)
                    
                    if !filteredRecipes.isEmpty {
                        NavigationLink(destination: RecipesView(filteredRecipes: filteredRecipes), isActive: .constant(true)) {
                            EmptyView()
                        }
                    }
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



