//
//  ViewController.swift
//  FindFlower
//
//  Created by Sam Ma on 12/3/17.
//  Copyright © 2017 Sam Ma. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    let wikiUrl = "https://en.wikipedia.org/w/api.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let userPickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            guard let convertedCIImage = CIImage(image: userPickedImage) else {
                
                fatalError("cannot convert to ciimage")
            }
            
            detect(image: convertedCIImage)
            imageView.image = userPickedImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detect(image: CIImage) {
        
        // use your own classifier mlmodel to get the cncoremlmodel
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
            
            fatalError("cannot import model")
        }
        
        // init a ml classify request
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            guard let classification = request.results?.first as? VNClassificationObservation else {
                
                fatalError("cannot classify image")
            }
            
            self.navigationItem.title = classification.identifier.capitalized
            
            self.requestInfo(flowerName: classification.identifier)
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            
            // run that request
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    func requestInfo (flowerName: String) {
        
        let parameters: [String: String] = [
            "format": "json",
            "action": "query",
            "prop": "extracts|pageimages",
            "exintro": "",
            "explaintext": "",
            "indexpageids": "",
            "titles": flowerName,
            "redirects": "1",
            "pithumbsize": "500"
            
        ]
        
        Alamofire.request(wikiUrl, method: .get, parameters: parameters).responseJSON { (response) in
            if response.result.isSuccess {
                
                print(response)
                let flowerJSON: JSON = JSON(response.result.value!)
                let pageId = flowerJSON["query"]["pageids"][0].stringValue
                let flowerDescription = flowerJSON["query"]["pages"][pageId]["extract"].stringValue
                let flowerImgUrl = flowerJSON["query"]["pages"][pageId]["thumbnail"]["source"].stringValue
                
                self.imageView.sd_setImage(with: URL(string: flowerImgUrl))
                self.label.text = flowerDescription
                self.label.adjustsFontSizeToFitWidth = false
                self.label.lineBreakMode = .byTruncatingTail
            }
        }
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
}

