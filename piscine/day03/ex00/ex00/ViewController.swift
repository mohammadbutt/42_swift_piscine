//
//  ViewController.swift
//  ex00
//
//  Created by Mohammad Butt on 10/16/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
//
// Allowed functions : Swift Standard Library, UIKit, UIImagePickerController
//
// Exercise 00: Photo Gallery App
//
// We will create an app that will access and load multiple images stored in device memory. List photos by
// name, and on open display image full screen.
//
// Reference: www.youtube.com/watch?v=4CbcMZOSmEk

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func chooseImageButton(_ sender: UIButton)
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Gallery app by Mohammad Butt", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler:
            {
                (action:UIAlertAction) in
                
                if UIImagePickerController.isSourceTypeAvailable(.camera)
                {
                    imagePickerController.sourceType = .camera
                    self.present(imagePickerController, animated: true, completion: nil)
                }
                else
                {
                    print("Camera not avilable on the simulator")
                }
            }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler:
            {
                (action:UIAlertAction) in imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
                
            }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated:  true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

