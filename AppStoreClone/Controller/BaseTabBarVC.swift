import UIKit

class BaseTabBarVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let todayVC = self.makeTabItem(viewController: UIViewController(), title: "Hoje", image: "icone-hoje")
        let appsVC = self.makeTabItem(viewController: UIViewController(), title: "Apps", image: "icone-apps")
        let searchVC = self.makeTabItem(viewController: SearchVC(), title: "Busca", image: "icone-busca")
        
            viewControllers = [
                todayVC,
                appsVC,
                searchVC
            ]
        
        selectedIndex = 2
    }
    
    func makeTabItem(viewController: UIViewController, title: String, image: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        
        viewController.navigationItem.title = title
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: image)
        viewController.view.backgroundColor = .white
        return navController
    }
}
