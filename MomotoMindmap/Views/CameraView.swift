//
//  CameraView.swift
//  MomotoMindmap
//
//  Created by Kezia Meilany Tandapai on 01/05/26.
//

import SwiftUI
import UIKit

struct CameraView: View {
    let onTextCaptured: (String) -> Void
    @State private var text: String = ""
    @StateObject private var camera = CameraSessionService()
    @StateObject private var ocr = OCRViewModel()
    @State private var capturedImage: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 16) {
            cameraArea
            textArea
            buttonRow
            shutter
        }
        .navigationTitle("Scan With Camera")
        .onAppear { camera.bootstrap() }
        .onDisappear { camera.stop() }
    }
    @ViewBuilder
      private var cameraArea: some View {
          Group {
              if let capturedImage {
                  Image(uiImage: capturedImage)
                      .resizable()
                      .scaledToFill()
              } else if camera.accessState == .allowed {
                  CameraPreview(session: camera.session)
              } else {
                  Text("Camera access is denied")
                      .foregroundStyle(.white)
              }
          }
          .frame(height: 360)
          .background(Color.black)
      }
    
    private var textArea: some View {
        ScrollView {
            Text(ocr.scannedText.isEmpty
            ? "Tap the shutter"
                 : ocr.scannedText)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 130)
    }
    private var buttonRow: some View {
        HStack {
            Button("Clear") { clear() }
            
            Spacer()
            
            Button("Make the mindmap") { handleGenerate() }
                .disabled(ocr.scannedText.count < 10)
        }
    }
    private var shutter: some View {
        Button(action: handleShutter) {
            Circle()
                .fill(Color.white)
                .frame(width: 70, height: 70)
                .overlay(Circle().stroke(Color.gray, lineWidth: 4))
        }
        .disabled(camera.accessState != .allowed || ocr.isProcessing)
    }
    
    private func handleShutter() {
        Task {
            guard let image = await camera.capturePhoto() else { return }
            capturedImage = image
            _ = await ocr.processScannedPages([image])
        }
    }
    private func clear() {
        capturedImage = nil
        ocr.scannedText = ""
    }
    
    private func handleGenerate() {
        let text = ocr.scannedText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }
        onTextCaptured(text)
        dismiss()
    }
}


#Preview {
    NavigationStack {
        CameraView { text in
            print("Preview captured text: \(text)")
        }
    }
}
