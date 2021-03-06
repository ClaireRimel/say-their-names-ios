//
//  PersonController.swift
//  Say Their Names
//
//  Copyright (c) 2020 Say Their Names Team (https://github.com/Say-Their-Name)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

enum PersonCellType: Equatable {
    case photo
    case info
    case story
    case outcome
    case news([Person])
    case medias([Person])
    case hashtags
    
    var identifier: String {
        switch self {
        case .photo: return PersonPhotoTableViewCell.reuseIdentifier
        case .info: return PersonInfoTableViewCell.reuseIdentifier
        case .story: return PersonOverviewTableViewCell.reuseIdentifier
        case .outcome: return PersonOverviewTableViewCell.reuseIdentifier
        case .news: return PersonNewsTableViewCell.reuseIdentifier
        case .medias: return PersonMediaTableViewCell.reuseIdentifier
        case .hashtags: return PersonHashtagTableViewCell.reuseIdentifier
        }
    }
    
    var accessibilityIdentifier: String {
        switch self {
        case .photo: return "PersonCellType_Photo"
        case .info: return "PersonCellType_Info"
        case .story: return "PersonCellType_Story"
        case .outcome: return "PersonCellType_Outcome"
        case .news: return "PersonCellType_News"
        case .medias: return "PersonCellType_Media"
        case .hashtags: return "PersonCellType_Hashtags"
        }
    }
    
    func register(to tableView: UITableView) {
        switch self {
        case .photo:
            tableView.register(cellType: PersonPhotoTableViewCell.self)
        case .info:
            tableView.register(cellType: PersonInfoTableViewCell.self)
        case .story:
            tableView.register(cellType: PersonOverviewTableViewCell.self)
        case .outcome:
            tableView.register(cellType: PersonOverviewTableViewCell.self)
        case .news:
            tableView.register(cellType: PersonNewsTableViewCell.self)
        case .medias:
            tableView.register(cellType: PersonMediaTableViewCell.self)
        case .hashtags:
            tableView.register(cellType: PersonHashtagTableViewCell.self)
        }
    }
    
    static var allCases: [PersonCellType] {
        return [.photo, .info, .story, .outcome, .news([]), .medias([]), .hashtags]
    }
}

// Alias for donation container view
typealias DontainButtonContainerView = ButtonContainerView

class PersonController: UIViewController {
    
    public var person: Person!
    
    private let donationButtonContainerView = DontainButtonContainerView(frame: .zero)
    
    private let tableViewCells: [PersonCellType] = {
        return [.photo, .info, .story, .outcome, .news([]), .medias([]), .hashtags]
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.insetsContentViewsToSafeArea = false
        tableView.backgroundColor = .clear
        tableView.contentInset = .init(top: Theme.Components.Padding.medium)
        return tableView
    }()
    
    lazy var backgroundFistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "STN-Logo-white")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var dismissButton: UIButton = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissAction(_:)))
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "Close Icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: Theme.Components.Button.Size.small.width,
                              height: Theme.Components.Button.Size.small.height)
        button.addGestureRecognizer(gesture)
        button.accessibilityLabel = L10n.close
        return button
    }()

    lazy var shareButton: UIButton = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(shareAction(_:)))
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "share_white")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: Theme.Components.Button.Size.small.width,
                              height: Theme.Components.Button.Size.small.height)
        button.addGestureRecognizer(gesture)
        button.accessibilityLabel = L10n.share
        return button
    }()
    
    // TODO: Once Theme.swift/etc. gets added to the project this should get moved there.
    let navigationBarTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont.STN.navBarTitle
    ]
    
    required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = "personView"
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.STN.red
        setupNavigationBarItems()
        setupSubViews()
    }
    
    @objc func dismissAction(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func shareAction(_ sender: Any) {
        // TODO: Share button action
    }
    
    private func registerCells(to tableView: UITableView) {
        PersonCellType.allCases.forEach { $0.register(to: tableView) }
    }
}

// MARK: - UIView Setup Methods
private extension PersonController {
    
    func setupNavigationBarItems() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.STN.black
        // TODO: Once Theme.swift/etc gets added this may not be required
        navigationController?.navigationBar.titleTextAttributes = navigationBarTextAttributes

        title = L10n.Person.sayTheirNames.uppercased()
        accessibilityLabel = L10n.Person.sayTheirNames

        navigationController?.navigationBar.titleTextAttributes = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont.STN.navBarTitle
        ]
       
       navigationItem.leftBarButtonItem = UIBarButtonItem(customView: dismissButton)
       navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
    }
    
    func setupSubViews() {
        backgroundFistImageView.anchor(superView: view, top: view.topAnchor,
                                       padding: .init(top:Theme.Components.Padding.large), size: Theme.Screens.Home.Person.backgroundFistSize)
        backgroundFistImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        setupTableView()
        setupDonationBottomView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.anchor(superView: view, top: view.topAnchor, leading: view.leadingAnchor,
                         bottom: nil, trailing: view.trailingAnchor,
                         padding: .zero, size: .zero)
        
        registerCells(to: tableView)
    }
    
    func setupDonationBottomView() {
        donationButtonContainerView.translatesAutoresizingMaskIntoConstraints = false
        donationButtonContainerView.anchor(superView: view, top: nil, leading: view.leadingAnchor,
                                           bottom: view.bottomAnchor, trailing: view.trailingAnchor,
                                           padding: .zero,
                                           size: CGSize(width: view.bounds.width, height: Theme.Screens.Home.Person.donationViewHeight))
        
        tableView.anchor(superView: nil, top: nil, leading: nil,
                         bottom: donationButtonContainerView.topAnchor, trailing: nil,
                         padding: .zero, size: .zero)
        
        donationButtonContainerView.setButtonPressed {
            // TODO: Donation button action
        }
    }
}

// MARK: - UITableViewDelegate Methods
extension PersonController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource Methods
extension PersonController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = tableViewCells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath)
        
        switch cellType {
        case .photo:
            let photoCell = cell as! PersonPhotoTableViewCell
            photoCell.setupCell(person)
            return photoCell
        case .info:
            let infoCell = cell as! PersonInfoTableViewCell
            infoCell.setupCell(person)
            return infoCell
        case .story:
            let storyCell = cell as! PersonOverviewTableViewCell
            storyCell.setupCell(title: L10n.Person.theirStory, description: person.bio)
            return storyCell
        case .outcome:
            let overviewCell = cell as! PersonOverviewTableViewCell
            overviewCell.setupCell(title: L10n.Person.outcome, description: person.context)
            return overviewCell
        case let .news(news):
            let newsCell = cell as! PersonNewsTableViewCell
            newsCell.cellDelegate = self
            newsCell.registerCell(with: PersonNewsCollectionViewCell.self, type: PersonNewsCellType.news)
            newsCell.updateCellWithNews(news)
            return cell
        case let .medias(news):
            let newsCell = cell as! PersonMediaTableViewCell
            newsCell.cellDelegate = self
            newsCell.registerCell(with: PersonMediaCollectionViewCell.self, type: PersonNewsCellType.medias)
            newsCell.updateCellWithNews(news)
            return cell
        case .hashtags:
            let hashtagsCell = cell as! PersonHashtagTableViewCell
            hashtagsCell.registerCell(with: PersonHashtagCollectionViewCell.self)
            return hashtagsCell
        }
    }
}

// MARK: - CollectionViewCellDelegate Methods
extension PersonController: CollectionViewCellDelegate {
    
    func collectionView(collectionviewcell: UICollectionViewCell?, index: Int, didTappedInTableViewCell: UITableViewCell) {
        print("\(index) tapped")
    }
}
