//
//  ViewController.swift
//  KOLocalized
//
//  Created by Oleksandr Khymych on 25.09.16.
//  Copyright © 2016 Oleksandr Khymych. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var button: UIButton!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        textLabel.text = KOLocalized("kLanguage")
        button.titleLabel?.text = KOLocalized("kChangeLanguage")
    }
}

class langViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func en(_ sender: AnyObject) {
        KOLocalizedClass.instance.changeLocalizedWithKey("en")
        self.navigationController!.popViewController(animated: true)
    }
    @IBAction func ru(_ sender: AnyObject) {
        KOLocalizedClass.instance.changeLocalizedWithKey("ru")
        self.navigationController!.popViewController(animated: true)
    }
}
