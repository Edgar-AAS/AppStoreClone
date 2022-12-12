import UIKit

class TodayDetailMultipleVC: UITableViewController {
    var todayApp: TodayApp? {
        didSet {
            if let todayApp = todayApp {
                let header = TodayMultipleHeader(frame: .init(x: 0, y: 0, width: view.bounds.width, height: 145))
                header.todayApp = todayApp
                tableView.tableHeaderView = header
                tableView.reloadData()
            }
        }
    }
    
    var handlerClick: ((App) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TodayMultipleTableViewCell.self, forCellReuseIdentifier: TodayMultipleTableViewCell.reuseIdentifier)
        tableView.separatorInset = .init(top: 0, left: 90, bottom: 0, right: 24)
    }
        
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todayApp?.apps?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodayMultipleTableViewCell.reuseIdentifier, for: indexPath) as? TodayMultipleTableViewCell
        cell?.app = self.todayApp?.apps?[indexPath.item]
        cell?.leadingConstraint?.constant = 24
        cell?.trailingConstraint?.constant = -24
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let app = self.todayApp?.apps?[indexPath.item] {
            self.handlerClick?(app)
        }
    }
    
}
