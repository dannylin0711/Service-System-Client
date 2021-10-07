//
//  TroubleshootViewController.swift
//  Instant Support
//
//  Created by Danny Lin on 2/3/21.
//

import UIKit
import ImageSlideshow

class TroubleshootViewController: UIViewController {

    var errorcode:String = ""
    var errorDescription:String = ""
    
    var currentHardwareType:String?
    var machineID:String?
    @IBOutlet weak var errorDescriptionTextView: UITextView!
    @IBOutlet weak var errorTroubleshootSlideshow: ImageSlideshow!
    
    let demo1:[String] = []
    let demo2:[String] = []
    let demo3:[String] = ["demo1","demo2","demo3","demo4","demo5","demo6"]
    let demo4:[String] = ["demo7"]
    let demo5:[String] = ["demo8","demo9"]
    
    var temp:[ImageSource] = []
    
    @IBOutlet weak var errorcodeLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorDescriptionTextView.isEditable = false
        self.errorcodeLabel.text = errorcode
        self.errorDescriptionTextView.text = errorDescription
        self.errorTroubleshootSlideshow.circular = false
        self.errorTroubleshootSlideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .customUnder(padding: 10))
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = .darkGray
        pageIndicator.pageIndicatorTintColor = .lightGray
        self.errorTroubleshootSlideshow.pageIndicator = pageIndicator
        temp = getCorrectArray(errorCode: errorcode)
        if temp.count <= 0{
            self.errorTroubleshootSlideshow.isHidden = true
        }else{
            self.errorTroubleshootSlideshow.setImageInputs(temp)
        }
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        errorTroubleshootSlideshow.addGestureRecognizer(gestureRecognizer)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func supportButtononAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MachineViewController") as! MachineViewController
        //        vc.modalPresentationStyle = .popover
        //vc.currentHardwareType = currentHardwareType
        
        vc.currentHardwareType = currentHardwareType
        vc.machineID = machineID
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func getCorrectArray(errorCode:String) -> [ImageSource]{
        var temp:[ImageSource] = []
        switch errorcode {
        case "Photocal cuvette error":
            for image in demo3{
                temp.append(ImageSource(image: UIImage(named: image)!))
            }
        case "8001 CONSOLE-ANL COMMUNICATION ERROR":
            for image in demo4{
                temp.append(ImageSource(image: UIImage(named: image)!))
            }
        case "Photometry Error During a Cuvette Wash alarm":
            for image in demo5{
                temp.append(ImageSource(image: UIImage(named: image)!))
            }
        default:
            break
        }
        return temp
    }
    
    @objc func didTap(){
       errorTroubleshootSlideshow.presentFullScreenController(from: self)
        
    }
    /*
    // MARK: - Navigation
     "Perform A W1","3120 SAMPLE TRANSFER COMPONENT (FA) UP/DOWN MOTION ERROR (A, B)[A, B, C, D]",
                                       "Photocal cuvette error","8001 CONSOLE-ANL COMMUNICATION ERROR",
                                       "Photometry Error During a Cuvette Wash alarm"
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension FullScreenSlideshowViewController{
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get { return [.landscape,.landscapeLeft,.landscapeRight,.portrait] }
    }
}
