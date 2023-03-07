//
//  ImagePicker.swift
//  Filter
//
//  Created by cmStudent on 2023/03/06.
//

import SwiftUI

struct ImagePicker {
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType
}

extension ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}

final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: ImagePicker

    init(parent: ImagePicker) {
        self.parent = parent
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        parent.image = originalImage
        parent.isShown = false
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parent.isShown = false
    }
}
