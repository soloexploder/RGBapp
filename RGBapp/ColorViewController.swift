//
//  ViewController.swift
//  RGBapp
//
//  Created by MacBook on 27.03.2021.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet weak var redTF: UITextField!
    @IBOutlet weak var greenTf: UITextField!
    @IBOutlet weak var blueTF: UITextField!
    
    //MARK: public properties
    var viewColor: UIColor!
    var delegate: ColorViewControllerDelegate!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorView.layer.cornerRadius = 15
        colorView.backgroundColor = viewColor
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        setSliders()
        setValue(for: redLabel, greenLabel, blueLabel)
        setValueTF(for: redTF, greenTf, blueTF)
    }

    @IBAction func rgbSlider(_ sender: UISlider) {
        colorSetting()
        
        switch sender {
        case redSlider:
            setValue(for: redLabel)
            setValueTF(for: redTF)
        case greenSlider:
            setValue(for: greenLabel)
            setValueTF(for: greenTf)
        default:
            setValue(for: blueLabel)
            setValueTF(for: blueTF)
        }
    }
    
    @IBAction func doneButton() {
        delegate?.setColor(colorView.backgroundColor ?? .white)
        dismiss(animated: true)
    }
     
    private func colorSetting() {
        colorView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                            green: CGFloat(greenSlider.value),
                                            blue: CGFloat(blueSlider.value),
                                            alpha: 1)
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                label.text = string(from: redSlider);
            case greenLabel:
                label.text = string(from: greenSlider)
            default:
                label.text = string(from: blueSlider)
            }
        }
    }
    
    private func setValueTF(for textFields: UITextField...) {
        textFields.forEach { textField in
            switch textField {
            case redTF:
                textField.text = string(from: redSlider);
            case greenTf:
                textField.text = string(from: greenSlider)
            default:
                textField.text = string(from: blueSlider)
            }
        }
    }
    
    private func setSliders() {
        let ciColor = CIColor(color: viewColor)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f",slider.value)
    }
    
    @objc private func didTapDone() {
        view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension ColorViewController: UITextFieldDelegate {
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
        
    func textFieldDidEndEditing(_ textField: UITextField) {
            guard let text = textField.text else { return }
            
            if let currentValue = Float(text) {
                switch textField {
                case redTF:
                    redSlider.setValue(currentValue, animated: true)
                    setValue(for: redLabel)
                case greenTf:
                    greenSlider.setValue(currentValue, animated: true)
                    setValue(for: greenLabel)
                default:
                    blueSlider.setValue(currentValue, animated: true)
                    setValue(for: blueLabel)
                }
                colorSetting()
                return
        }
        showAlert(title: "Wrong format", message: "Please enter correct value")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.barStyle = .black
        textField.inputAccessoryView = keyboardToolBar
        keyboardToolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(didTapDone))
        
        let flexBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                      target: nil,
                                      action: nil)
        
        keyboardToolBar.items = [flexBar,doneButton]
    }
}
