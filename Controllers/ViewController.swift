//
//  ViewController.swift
//  Social Media Feed
//
//  Created by Xan Xanzaki on 04/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    var posts: [Post] = []
    let refreshController = UIRefreshControl()
    
    lazy  var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(PostCell.self, forCellReuseIdentifier: "PostCell")
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 249/255, blue: 252/255, alpha: 1)
        setUpUI()
        loadData()
        
    }
    func setUpUI(){
        title = "FEED"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(refreshFeed), for: .valueChanged)
        
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    @objc func handleAdd(_ sender: UIBarButtonItem){
        let card = AddPostCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.onSave = { [weak self] title, body in
            self?.savePost(title: title, body: body)
        }
        view.addSubview(card)
        
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: view.topAnchor),
            card.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            card.leftAnchor.constraint(equalTo: view.leftAnchor),
            card.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    func savePost(title: String, body: String){
        let context = AppDelegate.shared.persistentContainer.viewContext
        let post = Post(context: context)
        post.id = Int64(Int.random(in: 1000...9999))
        post.userName =  ["anna.krasiva", "maksim_zhizn", "dasha.luna", "ivan.vputi", "katya.solnce", "sasha.dreams", "masha.risunok",
                          "nikita.codes", "lena.na.photo", "dima.vlog", "olia.rose", "andrey.hiker", "viktor.snap", "tanya.zvezda",
                          "ilya.blogs", "alisa.notes", "sergey.music", "nataly.life", "egor.motion", "irina.days", "timur.pixels",
                          "polina.sky", "vova_mir", "veronika.art", "pasha.smiles", "sofia.style", "arkady.glow", "vika.sunrise",
                          "kolya.journey", "yulia.travels", "stepan_vibes", "milana.view", "stas_thinks", "sveta.tunes", "roma.codes",
                          "elena.story", "artem.hustle", "zoya.lens", "bogdan.draws", "anastasia.pix", "kostya.moves", "valeria.vibes",
                          "leonid.walks", "karina.wave", "gleb_groove", "mira_snapz", "denis.clicks", "ksenia.love", "saveliy.journal",
                          "inna_vibe", "yaroslav.creates", "aliya.stories", "anton.arts", "daria_in.motion", "vitaliy.notes",
                          "vika.inspired", "vadim.chill", "alina.trips", "serafima.sunset", "nikolay.path", "kira.rose", "ilyusha.soul",
                          "ekaterina.dream", "maks_travel", "tatiana.fotos", "igor.waves", "sofi_reads", "yegor.crafts", "asya.naulitse",
                          "varya.smile", "mikhail_day", "liza.music", "sasha.arts", "deniska.here", "anya.hope", "boris.snap", "valya.jazz",
                          "elvira._art", "zhenya.vibes", "arina_in_life", "petya.plays", "tima_mind", "vika.muse", "nikita.hikes",
                          "sonya_life", "andrey.sea", "milena_journal", "oleg.codes", "katyusha.sings", "grisha.path", "oksana.smiles",
                          "slava.motion", "zina.pixels", "matvey.sketch", "aleks.nautro", "lera_clicks", "vlad_wanders", "diana.soul",
                          "sasha.na.foto", "nikifor.vibes", "nastya_na_style", "fedor.blog", "dasha_glow", "timofey.codes", "ulyana.vibe"].randomElement()!
        post.title = title
        post.body = body
        post.avatarURL = "https://i.pravatar.cc/150?img=\(Int.random(in: 1...70))"
        post.isLiked = false
        
        do{
            try context.save()
            posts = CoreDataServices.shared.fetchPosts()
            tableView.reloadData()
        } catch{
            print("Save Failed:", error)
        }
    }
    @objc func refreshFeed(){
        posts = CoreDataServices.shared.fetchPosts()
        tableView.reloadData()
        refreshController.endRefreshing()
    }
    func loadData(){
        let localPosts = CoreDataServices.shared.fetchPosts()
        print("Core Data has \(localPosts.count) posts")
        
        if localPosts.isEmpty{
            self.posts = localPosts
            self.tableView.reloadData()
            print("loaded")
        }else{
            print("Fetching from network")
            NetworkServices.shared.fetchPost { models in
                print("Got it \(models.count) posts from network")
                CoreDataServices.shared.savePosts(models)
                self.posts = CoreDataServices.shared.fetchPosts()
                print("After save core data has \(self.posts.count) posts")
                self.tableView.reloadData()
            }
        }
    }
    
}
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as!  PostCell
        cell.configure(with: post)
        cell.likeTapped = {
            CoreDataServices.shared.toggleLike(for: post)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        cell.backgroundColor = .clear
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let postToDelete = posts[indexPath.row]
            let alert = UIAlertController(title: "Delete Post", message: "Are you sure you want to delete this post?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
                let context = AppDelegate.shared.persistentContainer.viewContext
                context.delete(postToDelete)
                do{
                    try context.save()
                    self.posts.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
                catch {
                    print("Error deleting post: \(error)")
                }
            })
            present(alert, animated: true)
        }
    }
}
