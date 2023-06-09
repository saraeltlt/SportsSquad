//
//  LeagueDetailsViewController.swift
//  SportsSquad
//
//  Created by Sara Eltlt on 20/05/2023.
//
import UIKit

class LeagueDetailsViewController: UIViewController {
    
    var detailsViewModel: LeagueDetailsViewModel!
    
    @IBOutlet weak var networkIndecator: UIActivityIndicatorView!
    
    @IBOutlet weak var noUpcoming: UIButton!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    
    @IBOutlet weak var noLatest: UIButton!
    @IBOutlet weak var latestCollectionView: UICollectionView!
    
    @IBOutlet weak var noTeams: UIButton!
    @IBOutlet weak var teamsOrPlayerLabel: UILabel!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        setupCollectionViewDelegates()
        setupCollectionViewCells()
        bindViewModel()
        fetchData()
        setupCollectionViewLayouts()
        teamsOrPlayerLabel.text =  detailsViewModel.setTeamsLabel()
        if !NetworkStatusChecker.isInternetAvailable() {
            showToast(text: "No Internet Connection", imageName: K.NO_WIFI)
        }
    }
    
    private func configNavigationBar() {
        // Edit back button
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: K.BACK_ARROW), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        // Edit title
        let textAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: K.DARK_PURPLE)!,
            .font: UIFont(name: "Chalkduster", size: 17.0)!,
        ]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.title = "\(detailsViewModel.getleagueName())"
    }
    
    // MARK: - View Model Binding
    
    private func bindViewModel() {
        detailsViewModel?.bindNetworkIndicator.bind { [weak self] isLoading in
              DispatchQueue.main.async {
                  if let loading = isLoading{
                      if loading < 3 {
                          self?.networkIndecator.startAnimating()
                          
                      } else {
                          
                          self?.networkIndecator.stopAnimating()
                          self?.noUpcoming.isHidden = !(self?.detailsViewModel.upcomingList.isEmpty ?? true)
                          self?.noLatest.isHidden = !(self?.detailsViewModel.latestEventsList.isEmpty ?? true)
                          self?.noTeams.isHidden = !(self?.detailsViewModel.teamsList.isEmpty ?? true)
                          
                      }
                  }
              }
          }
     
        detailsViewModel.bindUpcomingListToLeagueDetailsVC.bind {  [weak self] isLoading in
            if let _ = isLoading{
                DispatchQueue.main.async {

                    self?.upcomingCollectionView.reloadData()
                }
            }
        }
        

        detailsViewModel.bindLatestEventListToLeagueDetailsVC.bind {  [weak self] isLoading in
            if let _ = isLoading{
                DispatchQueue.main.async {

                    self?.latestCollectionView.reloadData()
                }
            }
        }
        
        detailsViewModel.bindTeamsListToLeagueDetailsVC.bind {  [weak self] isLoading in
            if let _ = isLoading{
                DispatchQueue.main.async {

                    self?.teamsCollectionView.reloadData()
                }
            }
        }
        
    }
    
    // MARK: - Fetch Data
    
    private func fetchData() {
        detailsViewModel.fetchUpcomingEvents()
        detailsViewModel.fetchLatestEvents()
        detailsViewModel.fetchTeams()
    }
    
    // MARK: - Button Actions
    
    @IBAction func logoPressed(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Collection View Setup
    
    private func setupCollectionViewDelegates() {
        upcomingCollectionView.delegate = self
        upcomingCollectionView.dataSource = self
        
        latestCollectionView.delegate = self
        latestCollectionView.dataSource = self
        
        teamsCollectionView.delegate = self
        teamsCollectionView.dataSource = self
    }
    
    private func setupCollectionViewCells() {
        upcomingCollectionView.register(UINib(nibName: K.UPCOMING_EVENTS_CELL, bundle: nil), forCellWithReuseIdentifier: K.UPCOMING_EVENTS_CELL)
        
        latestCollectionView.register(UINib(nibName: K.LATEST_EVENTS_CELL, bundle: nil), forCellWithReuseIdentifier: K.LATEST_EVENTS_CELL)
        
        teamsCollectionView.register(UINib(nibName: K.TEAMS_CELL, bundle: nil), forCellWithReuseIdentifier: K.TEAMS_CELL)
    }
    
    private func setupCollectionViewLayouts() {
        let layout = UICollectionViewCompositionalLayout{
            index, enviroment in
            return self.createSection(groupWidthFraction: 0.8, groupHeightFraction: 1, groupContentInsets: NSDirectionalEdgeInsets(top: 16, leading: 10, bottom: 11, trailing: 0), orthogonalScrollingBehavior: .continuous)
        }
        upcomingCollectionView.setCollectionViewLayout(layout, animated: true)
        
        let layoutLatest = UICollectionViewCompositionalLayout{
            index, enviroment in
            return self.createSection(groupWidthFraction: 1, groupHeightFraction: 0.8, groupContentInsets: NSDirectionalEdgeInsets(top: 5, leading: 32, bottom: 5, trailing: 32))
        }
        latestCollectionView.setCollectionViewLayout(layoutLatest, animated: true)
        let layoutTeams = UICollectionViewCompositionalLayout{
            index, enviroment in
            return self.createSection(groupWidthFraction: 0.8, groupHeightFraction: 1, groupContentInsets: NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 0), itemFractionalWidth: 0.3333, orthogonalScrollingBehavior: .continuous)
        }
        teamsCollectionView.setCollectionViewLayout(layoutTeams, animated: true)
    }
    
    private func createSection(groupWidthFraction: CGFloat, groupHeightFraction: CGFloat, groupContentInsets: NSDirectionalEdgeInsets, itemFractionalWidth:CGFloat = 1, orthogonalScrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior? = nil) -> NSCollectionLayoutSection {
        // Item
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(itemFractionalWidth), heightDimension: .fractionalHeight(1)))
        
        // Group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupWidthFraction), heightDimension: .fractionalHeight(groupHeightFraction)), subitems: [item])
        group.contentInsets = groupContentInsets
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        
        if let scrollingBehavior = orthogonalScrollingBehavior {
            section.orthogonalScrollingBehavior = scrollingBehavior
        }
        
        return section
    }
}


