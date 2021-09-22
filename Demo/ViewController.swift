//
//  ViewController.swift
//  Demo
//
//  Created by kazuhiro nanko on 2021/09/22.
//

import UIKit
import StructuredQRCodeReader

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        main()
        
        configure()
    }
    
    func configure() {
        let button = UIButton(frame: .init(x: 100, y: 100, width: 150, height: 50))
        button.setTitle("カメラ起動", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc func tapButton() {
        print("aa")
    }
}
