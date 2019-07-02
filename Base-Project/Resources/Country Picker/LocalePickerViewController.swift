import UIKit

extension UIAlertController {

    /// Add Locale Picker
    ///
    /// - Parameters:
    ///   - type: country, phoneCode or currency
    ///   - action: for selected locale
    
    func addLocalePicker(type: LocalePickerViewController.Kind, selection: @escaping LocalePickerViewController.Selection) {
        var info: LocaleInfo?
        let selection: LocalePickerViewController.Selection = selection
        let buttonSelect: UIAlertAction = UIAlertAction(title: "Select", style: .default) { action in
            selection(info)
        }
        buttonSelect.isEnabled = false
        
        let vc = LocalePickerViewController(type: type) { new in
            info = new
            buttonSelect.isEnabled = new != nil
        }
        set(vc: vc)
        addAction(buttonSelect)
    }
}

final class LocalePickerViewController: UIViewController {
    
    // MARK: UI Metrics
    
    struct UI {
        static let rowHeight = CGFloat(50)
        static let separatorColor: UIColor = UIColor.lightGray.withAlphaComponent(0.4)
    }
    
    // MARK: Properties
    
    public typealias Selection = (LocaleInfo?) -> Swift.Void
    
    public enum Kind {
        case country
        case phoneCode
        case currency
    }
    
    fileprivate var type: Kind
    fileprivate var selection: Selection?
    
    fileprivate var preferredCountries = ["Lebanon"]
    fileprivate var suggestedCountries = [LocaleInfo]()
    
    fileprivate var orderedInfo = [String: [LocaleInfo]]()
    fileprivate var sortedInfoKeys = [String]()
    fileprivate var filteredInfo: [LocaleInfo] = []
    fileprivate var selectedInfo: LocaleInfo?
    
    //fileprivate var searchBarIsActive: Bool = false
    
    fileprivate lazy var searchView: UIView = UIView()
    
    fileprivate lazy var searchController: UISearchController = { [unowned self] in
        $0.searchResultsUpdater = self
        $0.searchBar.delegate = self
        $0.dimsBackgroundDuringPresentation = false
        /// true if search bar in tableView header
        $0.hidesNavigationBarDuringPresentation = true
        $0.searchBar.searchBarStyle = .minimal
        $0.searchBar.textField?.textColor = .black
        $0.searchBar.textField?.clearButtonMode = .whileEditing
        return $0
    }(UISearchController(searchResultsController: nil))
    
    fileprivate lazy var tableView: UITableView = { [unowned self] in
        $0.dataSource = self
        $0.delegate = self
        $0.rowHeight = UI.rowHeight
        $0.separatorColor = UI.separatorColor
        $0.bounces = true
        $0.backgroundColor = nil
        $0.tableFooterView = UIView()
        $0.sectionIndexBackgroundColor = .clear
        $0.sectionIndexTrackingBackgroundColor = .clear
        return $0
    }(UITableView(frame: .zero, style: .plain))
    
    fileprivate lazy var indicatorView: UIActivityIndicatorView = {
        $0.color = .lightGray
        return $0
    }(UIActivityIndicatorView(style: .whiteLarge))
    
    // MARK: Initialize
    
    required init(type: Kind, selection: @escaping Selection) {
        self.type = type
        self.selection = selection
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        // http://stackoverflow.com/questions/32675001/uisearchcontroller-warning-attempting-to-load-the-view-of-a-view-controller/
        let _ = searchController.view
        print("CountryPicker has deinitialized")
    }
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(indicatorView)
        
        searchView.addSubview(searchController.searchBar)
        tableView.tableHeaderView = searchView
        
        //extendedLayoutIncludesOpaqueBars = true
        //edgesForExtendedLayout = .bottom
        definesPresentationContext = true
        
        switch type {
        case .country:
            tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.identifier)
        case .phoneCode:
            tableView.register(PhoneCodeTableViewCell.self, forCellReuseIdentifier: PhoneCodeTableViewCell.identifier)
        case .currency:
            tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        }
        
        updateInfo()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.tableHeaderView?.height = 57
        searchController.searchBar.sizeToFit()
        searchController.searchBar.frame.size.width = searchView.frame.size.width
        searchController.searchBar.frame.size.height = searchView.frame.size.height
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        indicatorView.center = view.center
        preferredContentSize.height = tableView.contentSize.height
    }
    
    func updateInfo() {
        indicatorView.startAnimating()
        
        LocaleStore.fetch { [unowned self] result in
            switch result {
                
            case .success(let orderedInfo):
                let data: [String: [LocaleInfo]] = orderedInfo
                
                
                self.orderedInfo = data
                self.sortedInfoKeys = Array(self.orderedInfo.keys).sorted(by: <)
                
                self.preferredCountries
                    .filter{!$0.isEmpty}
                    .forEach{ country in
                    if let firstIndex  = self.orderedInfo["\(country.first!)"]?.firstIndex(where: {$0.country == country}){
                         self.suggestedCountries.append(self.orderedInfo["\(country.first!)"]!.remove(at: firstIndex))
                    }
                }
                
                print("Suggested Countries: \(self.suggestedCountries)")
                
                DispatchQueue.main.async {
                    self.indicatorView.stopAnimating()
                    self.tableView.reloadData()
                }
                
            case .error(let error):
                
                DispatchQueue.main.async {
                    
                    let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
                    alert.addAction(title: "OK", style: .cancel) { action in
                        self.indicatorView.stopAnimating()
                        self.alertController?.dismiss(animated: true)
                    }
                    alert.show()
                }
            }
        }
    }
    
    func sortFilteredInfo() {
        filteredInfo = filteredInfo.sorted { lhs, rhs in
            switch type {
            case .country:
                return lhs.country < rhs.country
            case .phoneCode:
                return lhs.country < rhs.country
            case .currency:
                return lhs.country < rhs.country
            }
        }
    }
    
    func info(at indexPath: IndexPath) -> LocaleInfo? {
        if searchController.isActive {
            return filteredInfo[indexPath.row]
        }
        switch indexPath.section {
        case 0:
            return suggestedCountries[indexPath.row]
        default:
            let key: String = sortedInfoKeys[indexPath.section == 1 ? 0 : indexPath.section - 1]
            if let info = orderedInfo[key]?[indexPath.row] {
                return info
            }
            return nil
        }
    }
    
    func indexPathOfSelectedInfo() -> IndexPath? {
        guard let selectedInfo = selectedInfo else { return nil }
        if searchController.isActive {
            for row in 0 ..< filteredInfo.count {
                if filteredInfo[row].country == selectedInfo.country {
                    return IndexPath(row: row, section: 0)
                }
            }
        }
        for section in 0 ..< sortedInfoKeys.count {
            if let orderedInfo = orderedInfo[sortedInfoKeys[section]] {
                for row in 0 ..< orderedInfo.count {
                    if orderedInfo[row].country == selectedInfo.country {
                        return IndexPath(row: row, section: section)
                    }
                }
            }
        }
        return nil
    }
}

// MARK: - UISearchResultsUpdating

extension LocalePickerViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchController.isActive {
            filteredInfo = []
            if searchText.count > 0, let values = orderedInfo[String(searchText[searchText.startIndex])] {
                filteredInfo.append(contentsOf: values.filter { $0.country.hasPrefix(searchText) })
                if searchText.count > 0 {
                    filteredInfo = orderedInfo.values.reduce([], +).filter {
                        var propertis: [String?] = [$0.country]
                        if type == .phoneCode {
                            propertis.append($0.phoneCode)
                        } else if type == .currency {
                            propertis.append(contentsOf: [$0.currencyName, $0.currencyCode, $0.currencySymbol])
                        }
                        return propertis.compactMap { $0?.lowercased().contains(searchText.lowercased()) }
                            .reduce(false, { $0 || $1 })
                    }
                }
            } else {
                orderedInfo.forEach { key, value in
                    filteredInfo += value
                }
            }
            sortFilteredInfo()
        }
        tableView.reloadData()
        
        guard let selectedIndexPath = indexPathOfSelectedInfo() else { return }
        print("selectedIndexPath = \(selectedIndexPath)")
        tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
    }
}

// MARK: - UISearchBarDelegate

extension LocalePickerViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

// MARK: - TableViewDelegate

extension LocalePickerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let info = info(at: indexPath) else { return }
        selectedInfo = info
        selection?(selectedInfo)
    }
}

// MARK: - TableViewDataSource

extension LocalePickerViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchController.isActive {return 1}
        return sortedInfoKeys.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {return filteredInfo.count}
        
        switch section {
        case 0:
            return suggestedCountries.count
        default:
            if let infoForSection = orderedInfo[sortedInfoKeys[section - 1]] {
                return infoForSection.count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        if searchController.isActive {return 0}
        
        if orderedInfo[sortedInfoKeys[index == 0 || index == 1 ? 0 : index - 1]]!.count > 0 {
            tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: .top , animated: false)
        }
        return sortedInfoKeys.index(of: title)!
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if searchController.isActive { return nil }
        return sortedInfoKeys
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if searchController.isActive { return nil }
        switch section {
        case 0:
            return "Suggested Countries"
        default:
            return sortedInfoKeys[section - 1]
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let info = info(at: indexPath) else { return UITableViewCell() }
        
        let cell: UITableViewCell
        
        switch type {
            
        case .country:
            
            cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier) as! CountryTableViewCell
            cell.textLabel?.text = info.country
            cell.detailTextLabel?.textColor = .darkGray
            
            DispatchQueue.main.async {
                let size: CGSize = CGSize(width: 32, height: 24)
                let flag: UIImage? = info.flag?.imageWithSize(size: size, roundedRadius: 3)
                cell.imageView?.image = flag
                cell.setNeedsLayout()
                cell.layoutIfNeeded()
            }
            
            if let selected = selectedInfo, selected.country == info.country {
                cell.isSelected = true
            }
        case .phoneCode:
            if searchController.isActive {
                cell = tableView.dequeueReusableCell(withIdentifier: PhoneCodeTableViewCell.identifier) as! PhoneCodeTableViewCell
                cell.textLabel?.text = info.phoneCode
                cell.detailTextLabel?.text = info.country
                cell.detailTextLabel?.textColor = .darkGray
                
                DispatchQueue.main.async {
                    let size: CGSize = CGSize(width: 32, height: 24)
                    let flag: UIImage? = info.flag?.imageWithSize(size: size, roundedRadius: 3)
                    cell.imageView?.image = flag
                    cell.setNeedsLayout()
                    cell.layoutIfNeeded()
                }
                
                if let selected = selectedInfo, selected.country == info.country {
                    cell.isSelected = true
                }
            }else{
                switch indexPath.section {
                case 0:
                    cell = tableView.dequeueReusableCell(withIdentifier: PhoneCodeTableViewCell.identifier) as! PhoneCodeTableViewCell
                    cell.textLabel?.text = suggestedCountries[indexPath.row].phoneCode
                    cell.detailTextLabel?.text = suggestedCountries[indexPath.row].country
                    cell.detailTextLabel?.textColor = .darkGray
                    
                    DispatchQueue.main.async {
                        let size: CGSize = CGSize(width: 32, height: 24)
                        let flag: UIImage? = self.suggestedCountries[indexPath.row].flag?.imageWithSize(size: size, roundedRadius: 3)
                        cell.imageView?.image = flag
                        cell.setNeedsLayout()
                        cell.layoutIfNeeded()
                    }
                    
                    if let selected = selectedInfo, selected.country == suggestedCountries[indexPath.row].country {
                        cell.isSelected = true
                    }
                default:
                    cell = tableView.dequeueReusableCell(withIdentifier: PhoneCodeTableViewCell.identifier) as! PhoneCodeTableViewCell
                    cell.textLabel?.text = info.phoneCode
                    cell.detailTextLabel?.text = info.country
                    cell.detailTextLabel?.textColor = .darkGray
                    
                    DispatchQueue.main.async {
                        let size: CGSize = CGSize(width: 32, height: 24)
                        let flag: UIImage? = info.flag?.imageWithSize(size: size, roundedRadius: 3)
                        cell.imageView?.image = flag
                        cell.setNeedsLayout()
                        cell.layoutIfNeeded()
                    }
                    
                    if let selected = selectedInfo, selected.country == info.country {
                        cell.isSelected = true
                    }
                }
            }
            
           
        case .currency:
            cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier) as! CurrencyTableViewCell
            cell.textLabel?.text = info.currencyCode
            cell.detailTextLabel?.text = info.country
            cell.detailTextLabel?.textColor = .darkGray
            
            DispatchQueue.main.async {
                let size: CGSize = CGSize(width: 32, height: 24)
                let flag: UIImage? = info.flag?.imageWithSize(size: size, roundedRadius: 3)
                cell.imageView?.image = flag
                cell.setNeedsLayout()
                cell.layoutIfNeeded()
            }
            
            if let selected = selectedInfo, selected.country == info.country {
                cell.isSelected = true
            }
        }
        
        return cell
    }
}
