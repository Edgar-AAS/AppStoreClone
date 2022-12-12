import UIKit

class OnlyDetailVC: UITableViewController {
    var todayApp: TodayApp?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(OnlyDetailCell.self, forCellReuseIdentifier: OnlyDetailCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundColor = .white
        tableView.contentInsetAdjustmentBehavior = .never
        self.addHeader()
    }
    
    var referenceWidth: CGFloat?
    
    func addHeader() {
        let headerView = UIView(frame: .init(x: 0, y: 0, width: referenceWidth!, height: referenceWidth! + 48))
        
        let todayCell = TodayCell()
        todayCell.todayApp = self.todayApp
        todayCell.layer.cornerRadius = 0
        headerView.addSubview(todayCell)
        todayCell.fillSuperview()
        self.tableView.tableHeaderView = headerView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OnlyDetailCell.reuseIdentifier, for: indexPath) as? OnlyDetailCell
        return cell ?? UITableViewCell()
    }
}
