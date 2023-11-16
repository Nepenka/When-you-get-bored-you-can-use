//
//  ViewController.swift
//  When you get bored you can use
//
//  Created by 123 on 16.11.23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    var post: [Bored] = []
    let url = "https://www.boredapi.com/api/activity"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        
        makeRequest()
    }
    
    func makeRequest() {
        var request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            guard let data = data, let _ = response, error == nil else {
                print("Error Json: \(String(describing: error?.localizedDescription))")
                return
            }
            
            do {
                let bored = try JSONDecoder().decode(Bored.self, from: data)
                self?.post = [bored]
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            }catch{
                print("Error: \(error.localizedDescription)")
                print("Failed JSON Data: \(String(data: data, encoding: .utf8) ?? "")")
                print("Response JSON: \(String(data: data, encoding: .utf8) ?? "")")

            }
        }
        task.resume()
        
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
        let bored = post[indexPath.row]
        cell.configure(with: bored)
        cell.textLabel?.sizeToFit()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        return cell
    }
    
    
    
}

class TableViewCell: UITableViewCell {
    var titleLabel: UILabel!
        var typeLabel: UILabel!
        var participantsLabel: UILabel!
        var priceLabel: UILabel!
        var linkLabel: UILabel!
        var keyLabel: UILabel!
        var accessibilityInfoLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel()
        typeLabel = UILabel()
        participantsLabel = UILabel()
        priceLabel = UILabel()
        linkLabel = UILabel()
        keyLabel = UILabel()
        accessibilityInfoLabel = UILabel()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(typeLabel)
        contentView.addSubview(participantsLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(linkLabel)
        contentView.addSubview(keyLabel)
        contentView.addSubview(accessibilityInfoLabel)
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        participantsLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(participantsLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        linkLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        keyLabel.snp.makeConstraints { make in
            make.top.equalTo(linkLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        accessibilityInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(keyLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-8)
        }
    }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func configure(with bored: Bored) {
            titleLabel.text = "Activity: \(bored.activity)"
            typeLabel.text = "Type: \(bored.type)"
            participantsLabel.text = "Participants: \(bored.participants)"
            priceLabel.text = "Price: \(bored.price)"
            linkLabel.text = "Link: \(bored.link ?? "")"
            keyLabel.text = "Key: \(bored.key)"
            accessibilityInfoLabel.text = "Accessibility: \(bored.accessibility)"
        }
}

