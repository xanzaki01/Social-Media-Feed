//
//  PostCell.swift
//  Social Media Feed
//
//  Created by Xan Xanzaki on 04/07/25.
//

import UIKit
class PostCell: UITableViewCell{
    
    var likeTapped: (() -> Void)?
    
    // MARK: - UI Components
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var avatarImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nicolas Nile"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    lazy var headTitle: UILabel = {
        let label = UILabel()
        label.text = "Head Title"
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    lazy var bodyText: UILabel = {
        let label = UILabel()
        label.text = "Body Text"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    lazy var likeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(red: 216/255, green: 229/255, blue: 249/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "heart-2")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return button
    }()
    lazy var savedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(red: 216/255, green: 229/255, blue: 249/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var savedImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "save-instagram")?.withRenderingMode(.alwaysTemplate)
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.tintColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var commentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor(red: 216/255, green: 229/255, blue: 249/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var commentImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "chat")?.withRenderingMode(.alwaysTemplate)
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        view.tintColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainView)
        mainView.addSubview(avatarImageView)
        mainView.addSubview(nameLabel)
        mainView.addSubview(headTitle)
        mainView.addSubview(bodyText)
        mainView.addSubview(likeView)
        likeView.addSubview(likeButton)
        mainView.addSubview(savedView)
        savedView.addSubview(savedImageView)
        mainView.addSubview(commentView)
        commentView.addSubview(commentImageView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            mainView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            avatarImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            avatarImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 20),
            
            headTitle.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            headTitle.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10),
            
            bodyText.topAnchor.constraint(equalTo: headTitle.bottomAnchor, constant: 10),
            bodyText.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10),
            bodyText.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10),
            
            likeView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            likeView.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10),
            likeView.widthAnchor.constraint(equalToConstant: 30),
            likeView.heightAnchor.constraint(equalToConstant: 30),
            
            likeButton.centerXAnchor.constraint(equalTo: likeView.centerXAnchor),
            likeButton.centerYAnchor.constraint(equalTo: likeView.centerYAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 20),
            likeButton.heightAnchor.constraint(equalToConstant: 20),
            
            savedView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            savedView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10),
            savedView.widthAnchor.constraint(equalToConstant: 30),
            savedView.heightAnchor.constraint(equalToConstant: 30),
            
            savedImageView.centerXAnchor.constraint(equalTo: savedView.centerXAnchor),
            savedImageView.centerYAnchor.constraint(equalTo: savedView.centerYAnchor),
            savedImageView.widthAnchor.constraint(equalToConstant: 20),
            savedImageView.heightAnchor.constraint(equalToConstant: 20),
            
            commentView.rightAnchor.constraint(equalTo: savedView.leftAnchor, constant: -10),
            commentView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            commentView.widthAnchor.constraint(equalToConstant: 30),
            commentView.heightAnchor.constraint(equalToConstant: 30),
            
            commentImageView.centerXAnchor.constraint(equalTo: commentView.centerXAnchor),
            commentImageView.centerYAnchor.constraint(equalTo: commentView.centerYAnchor),
            commentImageView.widthAnchor.constraint(equalToConstant: 20),
            commentImageView.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    @objc func handleLike(){
        likeTapped?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with post: Post){
        headTitle.text = post.title
        bodyText.text = post.body
        nameLabel.text = post.userName ?? "Anonymus"
        likeButton.tintColor = post.isLiked ? .systemRed : .blue
        
        if let urlString = post.avatarURL, let url = URL(string: urlString){
            loadImage(from: url)
        }
    }
    private func loadImage(from url: URL){
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.avatarImageView.image = image
                }
            }else{
                DispatchQueue.main.async{
                    self.avatarImageView.image = UIImage(systemName: "person.crop.circle.fill")
                }
            }
        }
    }
}
