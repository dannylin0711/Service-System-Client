//
//  MachineViewController.swift
//  Instant Support
//
//  Created by Danny Lin on 1/29/21.
//

import UIKit

class MachineViewController: UIViewController {
    
    @IBOutlet weak var machineIdentifierLabel: UILabel!
    @IBOutlet weak var machineIDLabel: UILabel!
    @IBOutlet weak var machineImageView: UIImageView!
    
    var currentHardwareType:String?
    var machineID:String?
    
    var imageSet = [UIImage(named: "phone.fill.arrow.up.right"),UIImage(named: "doc.text.magnifyingglass"),UIImage(named: "display.trianglebadge.exclamationmark")/*,UIImage(named: "doc.fill")*/]
    var functionSet = ["Call Support","See Manual","Trouble Shooting"/*,"Quick Troubleshoot"*/]
    
    @IBOutlet weak var functionCollectionView: UICollectionView!
    @IBOutlet weak var functionCollectionViewFlowLayout: UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        machineIdentifierLabel.text = currentHardwareType
        machineIDLabel.text = machineID
        functionCollectionView.register(UINib(nibName: "MachineFunctionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        functionCollectionView.delegate = self
        functionCollectionView.dataSource = self
        functionCollectionViewFlowLayout.itemSize = CGSize(width: 150, height: 200)
        
        
        machineImageView.image = UIImage(named: currentHardwareType!.uppercased())
        
//        machineImageView.image = imageSet[0]
        // Do any additional setup after loading the view.
        //functionCollectionView.layoutSubviews()
        view.layoutSubviews()
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

extension MachineViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSet.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MachineFunctionCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MachineFunctionCollectionViewCell
        cell.functionImageView.image = imageSet[indexPath.row]
        cell.functionImageView.tintColor = UIColor.init(named: "SystemWhiteforOldiOS")
        cell.functionLabel.text = functionSet[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let totalCellWidth = 150 * 2
        let totalSpacingWidth = 20 * (2 - 1)
        
        let leftInset = (collectionView.bounds.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        switch indexPath.row {
        case 0:
            if let url = URL(string: "tel://0800315688"),
               UIApplication.shared.canOpenURL(url) {
                  if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler:nil)
                   } else {
                       UIApplication.shared.openURL(url)
                   }
               } else {
                        // add error message here
               }
//        case 3:
//            let vc = storyboard?.instantiateViewController(withIdentifier: "QuickTroubleshootViewController") as! QuickTroubleshootViewController
//            //        vc.modalPresentationStyle = .popover
//
//            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}



