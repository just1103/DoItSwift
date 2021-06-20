//
//  TableViewController.swift
//  12_TableViewController
//
//  Created by Hyoju Son on 2021/06/19.
//

import UIKit

var items = ["책 구매", "철수와 약속", "스터디 준비하기"] // 외부변수 선언 (모든 Class에서 해당 변수를 사용 가능함) - 전역변수와 어떻게 다른거지?
var itemsImageFile = ["cart.png","clock.png","pencil.png"] // 외부변수 선언

class TableViewController: UITableViewController {

    @IBOutlet var tvListView: UITableView! // cell 하단의 Table View (Prototype Content)와 연결
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    // return the number of sections - 보통 Table 내에 Section이 1개이므로 return값을 1로 지정 // section이 뭐지?
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // return the number of rows - Section당 Row 개수는 Item 개수이므로 return값을 items.count로 지정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    // insert a cell for the given index path (어떤 Row에 배치할지) - 변수의 내용을 Cell에 적용하는 함수 (제공된 주석을 Uncomment하여 작성)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) // withIdentifier에 storyboard에서 지정한 Cell Id 입력. *dequeue (Double-ended Queue /덱/) : 자료구조 형태. 양쪽에서 삽입/삭제가 가능한 특이한 큐. dequeueReusableCell 메서드 - recycles or creates the cell

        // Configure the cell...
        
        cell.textLabel?.text = items[(indexPath as NSIndexPath).row] // Cell의 textLabel에 items Array를 대입 (array1[index] 형태로 값에 접근)
        cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row]) // Cell의 imageView에 itemsImageFile Array를 대입
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
