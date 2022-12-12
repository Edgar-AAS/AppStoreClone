import UIKit

class SearchVC: UITableViewController, UISearchBarDelegate {
    private let service = Service()
    let searchController = UISearchController(searchResultsController: nil)
    
    private var apps = [App]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.searchCellReuseId)
        setupSearchBar()
    }
    
    func setupSearchBar() {
        navigationItem.searchController = self.searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "App Store"
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performLocalRequest(text: searchBar.text!)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.resignFirstResponder()
        searchBar.text = ""
    }
}

extension SearchVC {
    func performLocalRequest(text: String) {
        service.searchApps(text: text) { [weak self] (result) in
            switch result {
            case .success(let success):
                self?.apps = success
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchVC {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .init(tableView.bounds.width * 0.8)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.searchCellReuseId, for: indexPath) as? SearchCell else { return UITableViewCell() }
        cell.setupAppCell(app: apps[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
}
