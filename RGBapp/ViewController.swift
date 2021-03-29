//
//  ViewController.swift
//  RGBapp
//
//  Created by MacBook on 27.03.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelValue()
        
        colorView.layer.cornerRadius = 10
    }

    @IBAction func sliderAction() {
        
        labelValue()
        
        self.colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                                 green: CGFloat(greenSlider.value),
                                                 blue: CGFloat(blueSlider.value),
                                                 alpha: 1)
    }
    
    private func labelValue() {
        redLabel.text = String(format: "%.2f",redSlider.value)
        greenLabel.text = String(format: "%.2f",greenSlider.value)
        blueLabel.text = String(format: "%.2f",blueSlider.value)
    }
}

