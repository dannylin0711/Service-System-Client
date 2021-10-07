//
//  QuickTroubleshootViewController.swift
//  Instant Support
//
//  Created by Danny Lin on 2/22/21.
//

import UIKit
import ImageSlideshow

class QuickTroubleshootViewController: UIViewController {


    @IBOutlet weak var imageSlideshow: ImageSlideshow!
    
    var troubleshootpage = ["demo1","demo2","demo3","demo4","demo5","demo6","demo7","demo8","demo9"]
    override func viewDidLoad() {
        super.viewDidLoad()
        var temp:[ImageSource] = []
        for image in troubleshootpage{
            temp.append(ImageSource(image: UIImage(named: image)!))
        }
        imageSlideshow.setImageInputs(temp)
        imageSlideshow.circular = false
        imageSlideshow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .customBottom(padding: 10))
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
