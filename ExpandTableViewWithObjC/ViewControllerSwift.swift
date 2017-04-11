//
//  ViewControllerSwift.swift
//  ExpandTableViewWithObjC
//
//  Created by gatesakagi on 2017/4/11.
//  Copyright © 2017年 Gates. All rights reserved.
//

import UIKit

class ViewControllerSwift: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    // 定義資料
    let dataSectionArray:[String] = ["華文文學", "世界文學", "類型文學"]
    let dataCellArray:[[String]] = [["華文文學研究","華文文學研究","現代詩","現代詩","小說","華文文學人物傳記"],["世界文學總論","神話/寓言","世界詩集","日本文學","英美文學","法國文學","德國文學","俄國文學","義大利文學","西葡語文學","其他各國文學","世界文學人物傳記"],["驚悚／懸疑小說","推理小說","科幻小說","奇幻小說","武俠小說","歷史小說","大眾文學"]]
    var isExpand:[Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 用0代表收起，非0（不一定是1）代表展開，預設為全部都是收起的狀態
        for _ in 0..<dataSectionArray.count {
            isExpand.append(false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 如果是展開狀態，則全部都秀出來，反之就為0
        if (isExpand[section] == true) {
            return dataCellArray[section].count;
        } else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! CustomHeaderCell
        
        headerCell.labelSectiontitle.text = dataSectionArray[section]
        
        if (isExpand[section] == true) {
            headerCell.labelExpand.text = "▼"
        } else {
            headerCell.labelExpand.text = "▶︎"
        }
        headerCell.btnSection.tag = 666 + section
        headerCell.btnSection.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)
        
        //這裡要傳回cell的contentView，不然按下按鈕後會消失
        return headerCell.contentView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataCellArray[indexPath.section][indexPath.row]
        return cell
    }
    
    func buttonAction(sender:UIButton) {
        let section = sender.tag - 666
        
        isExpand[section] == false ? (isExpand[section] = true) : (isExpand[section] = false)
        //上面一行是這個判斷式的簡式
        /*
        if (isExpand[section] == false) {
            isExpand[section] = true
        } else {
            isExpand[section] = false
        }
        */
        
        self.tableView!.reloadSections(IndexSet(integer: section), with: .automatic)
    }
}
