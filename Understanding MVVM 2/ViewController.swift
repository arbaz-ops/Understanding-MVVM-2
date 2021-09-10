//
//  ViewController.swift
//  Understanding MVVM 2
//
//  Created by Mac on 18/01/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTable: UITableView!
    var pvm: PersonViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        myTable.delegate = self
        myTable.dataSource = self
        callViewModelForUIUpdate()
    }

    @IBAction func addTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Person", message: "Please Enter person's name.", preferredStyle: .alert)
        
        alert.addTextField { (nameTextField) in
            nameTextField.placeholder = "Name"
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
            let name = alert.textFields![0]
            if name.text?.isEmpty == true {
                print("Please enter person's name")
            }else {
                self.pvm.addPerson(name: name.text!)
            }
        }))
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }
    
    func callViewModelForUIUpdate() {
        self.pvm = PersonViewModel()
        self.pvm.bindPersonViewModelToController = {
            self.myTable.reloadData()
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pvm.persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mtc = myTable.dequeueReusableCell(withIdentifier: "mtc") as? MyTableViewCell
        mtc?.name.text = pvm.persons[indexPath.row]
        return mtc!
    }
    
    
}
