//
//  StartViewController.swift
//  RGBapp
//
//  Created by Даниил Хантуров on 11.04.2021.
//

import UIKit

protocol ColorViewControllerDelegate {
    func setColor(_ color: UIColor)
}

class StartViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let colorVc = segue.destination as? ColorViewController else {return}
        colorVc.viewColor = view.backgroundColor
        colorVc.delegate = self
    }
}

// MARK: ColorDelegate
extension StartViewController: ColorViewControllerDelegate {
    func setColor(_ color: UIColor){
        view.backgroundColor = color
    }
}
