//
//  GeneralTroubleshootingTableViewController.swift
//  Instant Support
//
//  Created by Danny Lin on 2/3/21.
//

import UIKit

class GeneralTroubleshootingTableViewController: UITableViewController {
    
    var currentMachine: Machine?
    
    var currentHardwareType:String? = ""
    var currentHardwareSerial:String? = ""
    var currentCustomerID:String? = ""
    
    @IBOutlet weak var notinlistButton: UIBarButtonItem!
    var troubleshootingID:[String] = ["Perform A W1","3120 SAMPLE TRANSFER COMPONENT (FA) UP/DOWN MOTION ERROR (A, B)[A, B, C, D]",
                                      "Photocal cuvette error","8001 CONSOLE-ANL COMMUNICATION ERROR",
                                      "Photometry Error During a Cuvette Wash alarm"]
    var troubleshootDescription:[String] = ["""
— 只要有強制切換到STOP都要執行W1
— Perform a W1 to clean the sample probe and cuvettes after you restart the system.
— 操作路徑MAINT. > Analyzer Maintenance > Maintenance > Select W1 [F5](approximately 19 minutes)
""","""
此範例以sample probe為例
儀器會轉為STOP mode
停機後確認問題(ex.檢體不足或Probe被異物卡住或cover未確實放好)
按Reset使其歸位
儀器回復到Stand by後必須檢視sample probe tip有無被撞歪
若有歪可自行更換probe
檢視probe位置有無在wash well中間
若排除問題後須執行W1
""","""
走至儀器後方打開上層背蓋
拆開wash nozzle unit並掛在指定掛鉤上
移除mixer放置在紗布上(避免碰歪)
打開反應盤上蓋
以棉棒取出有問題的cuvette(如右上圖所示)

棉棒與乾淨紗布清潔完cuvette
將cuvette放置回原本位置且要壓到底
放回wash nozzle uint並固定鎖好
放回mixer(注意S與L型位置不同)
執行Photocal(可以指定單一沒過的cuvette位置或做all cuvettes)
""","""
執行一般關機程序Home→點選END
按壓鍵盤 [Ctrl] + [Alt] + [Delete]  點選 Shutdown, and then OK(螢幕無反應時使用)

確定電腦關機後, 才可按壓儀器上的 ANALYZER STOP button (黑色) 等待5秒後按壓 RESET button (白色), 接著在5秒後按壓 ON button (綠色)

因為有當機狀況發生開機後儀器會出現「Database retrieval」點選OK
儀器重開後會進入WARM UP 模式(約90分鐘)若關機不滿5分鐘可以由 MAINT. > Analyzer Maintenance > Maintenance頁面中點選Standby The analyzer bypasses WARM UP to STANDBY  (特別注意還是要至少等20分鐘使儀器狀態穩定)
""","""
— Data不斷出現 *, ?, @, $, D, B, 與 ! 等相關 FLAG

—拆下Wash nozzle unit 移除Mixer後(一定要放在紗布上避免刮傷)， 打蓋反應盤的上蓋去確認cuvette是否因為Overflow而呈現濕潤狀態
"""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = true
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (currentMachine?.errorCodeArray.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = currentMachine?.errorCodeArray[indexPath.row].errorCodeName//[indexPath.row]
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 3
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let errorCode = currentMachine?.errorCodeArray[indexPath.row].errorCodeName//[indexPath.row]troubleshootingID[indexPath.row]
        let errorDescription = currentMachine?.errorCodeArray[indexPath.row].errorDescription//[indexPath.row]troubleshootingID[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "TroubleshootViewController") as! TroubleshootViewController
        //        vc.modalPresentationStyle = .popover
        vc.errorcode = errorCode!
        vc.errorDescription = errorDescription!
        
        vc.currentHardwareType = currentHardwareType
        vc.machineID = currentHardwareSerial
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func notinlistonAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MachineViewController") as! MachineViewController
        //        vc.modalPresentationStyle = .popover
        vc.currentHardwareType = currentHardwareType
        vc.machineID = currentHardwareSerial
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
