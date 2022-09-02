//
//  Bucket-ListViewController.swift
//  PraxisFreitag3
//
//  Created by Mirko Weitkowitz on 02.09.22.
//

import UIKit

class Bucket_ListViewController: UIViewController{
    
    
    
    //vorausgefüllt oder leer
    var todo_list: [String] = ["Paris", "Rom", "Split", "Nizza", "München", "Hamburg", "Sarajewo"]
    var war_ich_schon: [String] = []
    
    //Ein Outlet zur gesamten TableView ist notwendig, damit auf die tableview und alle Zellen zugegriffen werden kann
    
    @IBOutlet weak var mytableview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        mytableview.delegate = self
        mytableview.dataSource = self
        title = "Meine Wunsch-Liste"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add_todo(_:)))
        
    }
    
    //MARK: Edit button
    
    @IBAction func pressedEdit(_ sender: UIBarButtonItem) {
        
        self.mytableview.setEditing(!mytableview.isEditing, animated: true)
        
        if !mytableview.isEditing{
            sender.title = "Edit"
        } else {
            sender.title = "Done"
        }
    }
    
    
    
    //MARK: Hier ist der Code, welcher den Alert-Controller erstellt, sowie die Funktion des Add-Buttons ausführt
    @IBAction func add_todo(_ sender: UIBarButtonItem) {
    

        let alert = UIAlertController(title: "Wunsch Urlaub", message: "Bitte gib dein neues Ziel ein", preferredStyle: .alert)
        alert.addTextField()
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [self, weak alert] (_) in
            let TextField = alert?.textFields![0]
            if TextField?.text != ""{
                todo_list.append(TextField!.text!)
                mytableview.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func strikeThroughText (_ text:String) -> NSAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    
}

//MARK: Hier werden TableViewDelegate, TableViewDataSource sowie die Funktionen initialisiert

extension Bucket_ListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return todo_list.count
        }else{
            return war_ich_schon.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "möchte ich noch hin" : "war ich schon"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytableview.dequeueReusableCell(withIdentifier: "mycell", for: indexPath)
        
        //Hier wird jeder Zelle ihr Textinhalt gegeben
        if indexPath.section == 0{
            var content = cell.defaultContentConfiguration()
            content.text = todo_list[indexPath.row]
            cell.contentConfiguration = content
            cell.accessoryType = .none
        }else{
            if indexPath.section == 1{
                var content = cell.defaultContentConfiguration()
                content.text = war_ich_schon[indexPath.row]
                cell.contentConfiguration = content
                cell.accessoryType = .checkmark
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //swipe to delete
        if editingStyle == .delete{
            
            if indexPath.section == 0{
                todo_list.remove(at: indexPath.row)
                mytableview.deleteRows(at: [indexPath], with: .fade)
            }else{
                if indexPath.section == 1{
                    war_ich_schon.remove(at: indexPath.row)
                    mytableview.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //MARK: hier hinzufügen, dass bei antippen, ein checkmark gesetzt wird
        mytableview.deselectRow(at: indexPath, animated: true)
        
        guard let cell = mytableview.cellForRow(at: indexPath) else {return}
        
        if indexPath.section == 0{
            let data = todo_list[indexPath.row]
            mytableview.beginUpdates()
            war_ich_schon.append(data)
            todo_list.remove(at: indexPath.row)
            cell.accessoryType = .checkmark
            
            let newindexPath = NSIndexPath(row: war_ich_schon.firstIndex(of: data)!, section: 1)
            mytableview.moveRow(at: indexPath, to: newindexPath as IndexPath)
            mytableview.endUpdates()
        }else if indexPath.section == 1{
            let data = war_ich_schon[indexPath.row]
            mytableview.beginUpdates()
            todo_list.append(data)
            war_ich_schon.remove(at: indexPath.row)
            cell.accessoryType = .none
            
            let newindexPath = NSIndexPath(row: todo_list.firstIndex(of: data)!, section: 0)
            mytableview.moveRow(at: indexPath, to: newindexPath as IndexPath)
            mytableview.endUpdates()
        }
        
    }
    
}


