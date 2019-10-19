//
//  ViewController.swift
//  ex01MultiTouch
//
//  Created by Mohammad Butt on 10/16/19.
//  Copyright © 2019 Mohammad Butt. All rights reserved.
// Reference: www.youtube.com/watch?v=4CbcMZOSmEk
// www.youtube.com/watch?v=QS2mWk3fAWc - Did not use this, but might be useful

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var cameraLabel: UILabel!
    @IBAction func chooseImageButton(_ sender: UIButton)
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionsheet = UIAlertController(title: "Photo Gallery App by Mohammad Butt", message: "Choose a source", preferredStyle: .actionSheet)
        actionsheet.addAction(UIAlertAction(title: "Camera", style: .default, handler:
            {
                (action: UIAlertAction) in
                
                if UIImagePickerController.isSourceTypeAvailable(.camera)
                {
                    self.cameraLabel.text = ""
                    imagePickerController.sourceType = .camera
                    self.present(actionsheet, animated: true, completion: nil)
                }
                else
                {
                    self.cameraLabel.text = "xCode does not have access to camera"
                    print("xCode does not have access to camera")
                }
        
            }))
        
        actionsheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler:
            {
                (action: UIAlertAction) in
                
                self.cameraLabel.text = ""
                
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
        
        actionsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionsheet, animated: true, completion: nil)
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
// Added below for swipping

// Added above for swipping
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

