
import UIKit

protocol CharactersViewDelegate: AnyObject {
    func charactersViewDidLoad()
}

final class CharactersView: UIView {
    weak var delegate: CharactersViewDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 4/255, green: 12/255, blue: 30/255, alpha: 1)
        collectionView.register(CharacterCollectionViewCell.self,
                                forCellWithReuseIdentifier: CharacterCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 4/255, green: 12/255, blue: 30/255, alpha: 1)
        delegate?.charactersViewDidLoad()
        setupUI()
    }
    
    func setDelagates(collectionViewDelegate: UICollectionViewDelegate,
                   dataSource: UICollectionViewDataSource) {
        self.collectionView.delegate = collectionViewDelegate
        self.collectionView.dataSource = dataSource
    }
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - SetupUI
extension CharactersView {
    private func setupUI() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
