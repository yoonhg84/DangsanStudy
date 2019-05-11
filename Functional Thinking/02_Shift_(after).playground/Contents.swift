//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    private let tableView = StudyTableView()
    private let data: [Int] = (0..<100).map { $0 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = self.data
        
        tableView.numberOfRows = {
            data.count
        }
        tableView.cellForRow = { cell, indexPath in
            cell.textLabel?.text = data.map { "\($0)" }[indexPath.row]
            return cell
        }
        
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
}

class StudyTableView: UITableView, UITableViewDataSource {
    var numberOfRows: () -> Int = { return 0 }
    var cellForRow: (UITableViewCell, IndexPath) -> UITableViewCell = { cell, _ in cell }
    
    convenience init() {
        self.init(frame: .zero, style: .plain)
        
        register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cellForRow(cell, indexPath)
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
