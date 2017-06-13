//
//  ViewController.swift
//  coredata
//
//  Created by Frantic on 5/26/17.
//  Copyright © 2017 Frantic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titler: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //titler.text = NSLocalizedString("title_screen", comment: "ttit")
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.receiveLanguageChangedNotification(notification:)), name: kNotificationLanguageChanged, object: nil)
        
        configureViewFromLocalisation()
        //print(Localisator.sharedInstance.currentLanguage)
        print(getLanguage())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func configureViewFromLocalisation() {
        titler.text     = Localization("title_screen")
        
    }
    
    // MARK: - Notification methods
    
    func receiveLanguageChangedNotification(notification:NSNotification) {
        if notification.name == kNotificationLanguageChanged {
            configureViewFromLocalisation()
            //print(Localisator.sharedInstance.currentLanguage)
            print(getLanguage())

        }
    }
    
    // MARK: - Memory management
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: kNotificationLanguageChanged, object: nil)
    }

}

