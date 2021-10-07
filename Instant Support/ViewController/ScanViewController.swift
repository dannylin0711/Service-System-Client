//
//  ViewController.swift
//  Instant Support
//
//  Created by Danny Lin on 1/29/21.
//

import UIKit
import AVFoundation

class ScanViewController: UIViewController {
    
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrcodeFoundUIView:UIView?
    
    var currentHardwareType:String?
    var currentCustomerID:String?
    var currentHardwareSerial:String?
    
    var currentHardWare:Machine?
    
    @IBOutlet weak var scanUIView: UIView!
    
    @IBOutlet weak var hardwareTypeLabel: UILabel!
    @IBOutlet weak var customerIDLabel: UILabel!
    @IBOutlet weak var snLabel: UILabel!
    
    @IBOutlet weak var comfirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setQR()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setQR()
//        self.captureSession?.startRunning()
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @IBAction func comfirmButtonTouched(_ sender: Any) {
        self.captureSession?.stopRunning()
        SupportClient.sharedClient.getMachine(self, machineType: currentHardwareType!)
    }
    
    func setQR(){
//        let captureDevice = AVCaptureDevice.default(for: .video)
//        do{
//            let input:AnyObject =  try AVCaptureDeviceInput.init(device: captureDevice!)
//            captureSession = AVCaptureSession()
//            captureSession?.addInput(input as! AVCaptureInput)
//        }catch{
//            print("\(error)")
//        }
//
//        let captureMetadataOutput = AVCaptureMetadataOutput()
//        captureSession?.addOutput(captureMetadataOutput)
//        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//        captureMetadataOutput.metadataObjectTypes = [.qr]
        view.layoutSubviews()
        hardwareTypeLabel.text = " "
        customerIDLabel.text = " "
        snLabel.text = " "
        scanUIView.layer.cornerRadius = scanUIView.bounds.height / 8
        captureSession = AVCaptureSession()
        comfirmButton.isEnabled = false
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        
        let videoInput:AVCaptureDeviceInput
        do{
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        }catch let error{
            print(error)
            return
        }
        
        if (captureSession?.canAddInput(videoInput) ?? false ){
            captureSession?.addInput(videoInput)
        }else{
            return
        }
        
        //AVCaptureMetaDataOutput輸出影音資料，先實體化AVCaptureMetaDataOutput物件
        let metaDataOutput = AVCaptureMetadataOutput()
        if (captureSession?.canAddOutput(metaDataOutput) ?? false){
            captureSession?.addOutput(metaDataOutput)
            
            //關鍵！執行緒處理QRCode
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            //metadataOutput.metadataObjectTypes表示要處理哪些類型的資料，處理QRCODE
            metaDataOutput.metadataObjectTypes = [.qr]
            
        }else{
            return
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        //videoPreviewLayer?.frame=scanUIView.layer.frame
        videoPreviewLayer?.frame = scanUIView.layer.bounds
        videoPreviewLayer?.cornerRadius = scanUIView.layer.bounds.height / 8
        scanUIView.layer.addSublayer(videoPreviewLayer!)
        UIView.animate(withDuration: 0.3, animations: {
            self.captureSession?.startRunning()
        })
        
        
        
        qrcodeFoundUIView = UIView()
        qrcodeFoundUIView?.layer.borderColor = UIColor.green.cgColor
        qrcodeFoundUIView?.layer.borderWidth = 2
        scanUIView.addSubview(qrcodeFoundUIView!)
        scanUIView.bringSubviewToFront(qrcodeFoundUIView!)
        view.layoutSublayers(of: scanUIView.layer)
    }

}

extension ScanViewController:AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count == 0{
            qrcodeFoundUIView?.frame = CGRect.zero
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
//        let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj )
//        qrcodeFoundUIView?.frame = barCodeObject!.bounds
        
        let qrcodeString = metadataObj.stringValue
        let decodedString = qrcodeString?.split(separator: "&").reduce(into: [String:String](), {
            let de = $1.split(separator: "=")
            if let key = de.first,let value = de.last{
                $0[String(key)] = String(value)
            }
        })
        
        
        
        var support = true
        
        if decodedString!["hardwareType"] == nil {
            print("Not support")
            support = false
            return
        }else{
            currentHardwareType = decodedString!["hardwareType"]
            hardwareTypeLabel.text =  decodedString!["hardwareType"]
        }
        
        if decodedString!["customerID"] == nil {
            print("Not support")
            support = false
            return
        }else{
            currentCustomerID = decodedString!["customerID"]
            customerIDLabel.text =  decodedString!["customerID"]
        }
        if decodedString!["serial"] == nil {
            print("Not support")
            support = false
            return
        }else{
            currentHardwareSerial = decodedString!["serial"]
            snLabel.text =  decodedString!["serial"]
        }
        
        comfirmButton.isEnabled = support
        
        
        
        //print("\(metadataObj.stringValue)")
        
        
    }
}

//self.captureSession?.stopRunning()
//let vc = storyboard?.instantiateViewController(withIdentifier: "GeneralTroubleshootingTableViewController") as! GeneralTroubleshootingTableViewController
//vc.currentHardwareType = decodedString!["hardwareType"]
//vc.currentCustomerID = decodedString!["customerID"]
//vc.currentHardwareSerial = decodedString!["serial"]
//self.navigationController?.pushViewController(vc, animated: true)

extension ScanViewController: SupportHttpProtocol{
    func appDidGetMachineInfo(_ data: AnyObject) {
        let machineInfo = Machine(data: data)
        let vc = storyboard?.instantiateViewController(withIdentifier: "GeneralTroubleshootingTableViewController") as! GeneralTroubleshootingTableViewController
        vc.currentHardwareType = currentHardwareType
        vc.currentCustomerID = currentCustomerID
        vc.currentHardwareSerial = currentHardwareSerial
        vc.currentMachine = machineInfo
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
