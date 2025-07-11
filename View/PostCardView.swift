//
//  PostCardView.swift
//  Social Media Feed
//
//  Created by Xan Xanzaki on 09/07/25.
//

import UIKit
class AddPostCardView: UIView{
    var onSave: ((String, String) -> Void)?
    
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let titleField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Title"
        field.font = .systemFont(ofSize: 18, weight: .medium)
        field.textColor = .label
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    private let bodyField: UITextView = {
        let view = UITextView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.font = .systemFont(ofSize: 17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let addButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Add Post", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = .boldSystemFont(ofSize: 17)
        btn.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return btn
    }()
    init(){
        super.init(frame: .zero)
        setUpViews()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        blurView.addGestureRecognizer(tap)
        
    }
    private func setUpViews(){
        self.addSubview(blurView)
        self.addSubview(cardView)
        [titleField, bodyField, addButton].forEach{ cardView.addSubview($0) }
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: self.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blurView.rightAnchor.constraint(equalTo: self.rightAnchor),
            blurView.leftAnchor.constraint(equalTo: self.leftAnchor),
            
            cardView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cardView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 300),
            cardView.heightAnchor.constraint(equalToConstant: 250),
            
            titleField.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            titleField.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 20),
            titleField.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -20),
            titleField.heightAnchor.constraint(equalToConstant: 40),
            
            bodyField.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10),
            bodyField.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 20),
            bodyField.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -20),
            bodyField.heightAnchor.constraint(equalToConstant: 150),
            
            addButton.topAnchor.constraint(equalTo: bodyField.bottomAnchor, constant: 20),
            addButton.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 150),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),
        ])
        
        cardView.alpha = 0
        cardView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.25, animations: {
            self.cardView.alpha = 1
            self.transform = .identity
        })
    }
    @objc func handleSave(){
        let title = titleField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let body = bodyField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard !title.isEmpty else {
            shake(view: titleField)
            return
        }
        guard !body.isEmpty else {
            shake(view: bodyField)
            return
        }
        
        onSave?(title, body)
        dismissSelf()
    }
    @objc func dismissSelf(){
        self.removeFromSuperview()
    }
    private func shake(view: UIView){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunctions = [CAMediaTimingFunction(name: .linear)]
        animation.duration = 0.4
        animation.values = [-8, 8, -6, 6, -4, 4, 0]
        view.layer.add(animation, forKey: "shake")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
