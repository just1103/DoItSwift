//
//  TableViewController.swift
//  12_TableViewController
//
//  Created by Hyoju Son on 2021/06/19.
//
//  README.md
//  * UITableViewController 및 Navigation Controller를 활용하여 목록 기능을 구현
//  * 초기화면 Main View에서는 목록을 확인 가능함. 각 항목을 왼쪽으로 swipe 하면 '삭제' 버튼이 나타나며 삭제 가능함. 또한 좌측 상단의 'Edit' 버튼을 터치하면, 각 항목을 삭제 (항목 좌측 버튼을 터치) 하거나 행 이동 (항목 우측 버튼을 swipe) 이 가능함
//  * 우측 상단의 '+' 버튼을 터치하면, Add View 화면으로 이동함. 새로운 항목을 작성하고 'Add' 버튼을 터치하면, Main View로 다시 이동하며 추가된 항목이 업데이트됨 (Segue 및 외부 변수 사용)
//  * 목록의 각 항목을 터치하면, Detail View 화면으로 이동하며 해당 항목의 정보가 나타남 (Segue 및 prepare 함수 사용)

import UIKit

// 앱 실행 시 기본적으로 나타낼 목록
var items = ["책 구매", "철수와 약속", "스터디 준비하기"] // 외부변수 선언 (모든 Class에서 해당 변수를 사용 가능함)
var itemsImageFile = ["cart.png","clock.png","pencil.png"]

class TableViewController: UITableViewController {

    @IBOutlet var tvListView: UITableView! // Cell 하단의 Table View (Prototype Content)와 연결
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    // *Bar Button을 추가하여 Edit하는 기능 (storyboard library에서 Bar Button 추가하지 않음) - 1) Edit 버튼을 터치하면 Cell 좌측에 (-)버튼이 나타남
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem // Bar 우측에 Edit Button을 추가
        self.navigationItem.leftBarButtonItem = self.editButtonItem // Bar 좌측에 Edit Button을 추가 (Navigation Controller가 embed하는 View Controller가 있을 때, Navigation 위에 View Controller를 push하여 나타내기 위한 목적)
    }
    
    // [Add => Table] Add에서 추가한 내용을 Table List에 반영 (View가 노출될 때마다 List 데이터를 새로고침)
    override func viewWillAppear(_ animated: Bool) { // *viewWillAppear 함수를 추가 - View가 전환될 때 호출되는 함수 (View가 노출될 준비가 완료됐을 때 호출되며, View가 노출될 때마다 호출됨)
        tvListView.reloadData() // reloadData 함수를 추가 - Table View를 새로고침함
    }
    
    
    // MARK: - Table view data source

    // return the number of sections - 보통 Table 내에 Section이 1개이므로 return값을 1로 지정
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // return the number of rows - Section당 Row 개수는 Item 개수이므로 return값을 items.count로 지정
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    // insert a cell for the given index path - 변수의 내용을 Cell에 적용
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        // Configure the cell...
        
        cell.textLabel?.text = items[(indexPath as NSIndexPath).row] // Cell의 textLabel에 items Array를 대입 (array1[index] 형태로 값에 접근)
        cell.imageView?.image = UIImage(named: itemsImageFile[(indexPath as NSIndexPath).row])
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    // Override to support editing the table view. - 목록 삭제 (Cell을 왼쪽으로 밀면 'Delete' 버튼이 나타나고, 클릭하면 항목이 사라지게 지정)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            items.remove(at: (indexPath as NSIndexPath).row) // 선택한 row의 Cell (items 및 해당 이미지)을 삭제
            itemsImageFile.remove(at: (indexPath as NSIndexPath).row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    // Cell 삭제 시 'Delete' 버튼을 '삭제' 버튼으로 수정
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }

    
    // Override to support rearranging the table view. *Bar Button을 추가하여 Edit하는 기능 - 2) 목록 순서를 바꾸는 기능
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let itemToMove = items[(fromIndexPath as NSIndexPath).row] // (1) 이동시킬 Item을 임시 변수에 저장
        let itemImageToMove = itemsImageFile[(fromIndexPath as NSIndexPath).row]
        
        items.remove(at: (fromIndexPath as NSIndexPath).row) // (2) Item을 삭제 - 삭제한 Item 뒤의 Item index가 재정렬됨
        itemsImageFile.remove(at: (fromIndexPath as NSIndexPath).row)
        
        items.insert(itemToMove, at: (to as NSIndexPath).row) // (3) 임시 변수의 내용을 옮길 위치에 삽입 - 삽입한 Item 뒤의 Item index가 재정렬됨
        items.insert(itemImageToMove, at: (to as NSIndexPath).row)
    }
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // [Table => Detail] segue를 통해 화면 전환 (Detail View를 미리 준비함)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Table View 특정 cell의 정보를 Detail View label에 반영함
        if segue.identifier == "sgDetail" {
            let cell = sender as! UITableViewCell // Table View의 특정 cell 관련 정보를 캐스팅하여 cell 상수에 할당. *예제 11과 차이점 - indexPath를 구하는 부분을 추가
            let indexPath = self.tvListView.indexPath(for: cell) // 해당 cell의 indexPath를 구함
            
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.receiveItem(items[(indexPath! as NSIndexPath).row]) // Detail View Controller에서 정의한 receiveItem 함수를 호출하여 해당 cell 정보를 Detail View의 label에 반영
            
//            detailViewController.receivedItem = items[(indexPath! as NSIndexPath).row] // 마지막 코드 대체 가능 (label text에 바로 반영하면, receiveItem 함수가 필요 없음)
        }
    }
}
