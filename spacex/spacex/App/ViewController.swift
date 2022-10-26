//
//  ViewController.swift
//  spacex
//
//  Created by Karsten Westra on 26/10/2022.
//

import UIKit

class ViewController: UIViewController {

    private lazy var label = {
        let label = UILabel(frame: self.view.bounds)
        label.numberOfLines = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Space X"
        self.view.backgroundColor = UIColor.white
        self.label.text = "Loading..."

        self.view.addSubview(label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.label.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.label.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        ])


        let url = URL(string: "https://api.spacexdata.com/v3/launches/upcoming?pretty=true")
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error {
                DispatchQueue.main.async {
                    self.label.text = error.localizedDescription
                }
                return
            }
            if let data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        self.label.text = jsonString
                    }
                }
                return
            }
        })
        task.resume()
    }
}

