//
//  SearchVC.swift
//  Doodle
//
//  Created by Leeseungsoo on 2018. 1. 12..
//  Copyright © 2018년 DongkyuShin. All rights reserved.
//

import Foundation
import UIKit

class SearchVC: UIViewController {
    @IBOutlet var searchTableView: UITableView!
    @IBOutlet var searchCollectionView: UICollectionView!
    @IBOutlet var doodleSearchView: UIView!
    @IBOutlet var searchTxtFd: UITextField!
    @IBOutlet var nicknameSearchBtn: UIButton!
    @IBOutlet var doodleSearchBtn: UIButton!
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var nicknameSearchView: UIView!
    
    var flag : Int = 0
    let token = UserDefaults.standard.string(forKey: "token")
    
    var searchResultVO : [SearchResultVO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNaviBar()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        doodleSearchView.isHidden = true
        cancelBtn.isHidden = true
        cancelBtn.isEnabled = false
        searchTxtFd.addTarget(self, action: #selector(searchTextField), for: .editingChanged)
        nicknameSearchBtn.titleLabel?.layer.shadowColor = UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0).cgColor
        nicknameSearchBtn.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 0)
        nicknameSearchBtn.titleLabel?.layer.shadowRadius = 1
        nicknameSearchBtn.titleLabel?.layer.shadowOpacity = 0.8
        doodleSearchBtn.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
        doodleSearchBtn.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 0)
        doodleSearchBtn.titleLabel?.layer.shadowRadius = 1
        doodleSearchBtn.titleLabel?.layer.shadowOpacity = 0.8
        nicknameSearchView.layer.shadowColor = UIColor.init(red: 70.0/255.0, green: 70.0/255.0, blue: 70.0/255.0, alpha: 1.0).cgColor
        nicknameSearchView.layer.shadowOffset = CGSize(width: 0, height: 0)
        nicknameSearchView.layer.shadowRadius = 3
        nicknameSearchView.layer.shadowOpacity = 0.5
        // Do any additional setup after loading the view.
    }
    
    func setNaviBar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.title = "검색"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func nicknameSearch(_ sender: Any) {
        doodleSearchView.isHidden = true
        nicknameSearchBtn.titleLabel?.layer.shadowColor = UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0).cgColor
        nicknameSearchBtn.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
        doodleSearchBtn.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
        doodleSearchBtn.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 0.5), for: .normal)
        flag = 0
    }
    @IBAction func doodleSearch(_ sender: Any) {
        doodleSearchView.isHidden = false
        nicknameSearchBtn.titleLabel?.layer.shadowColor = UIColor.clear.cgColor
        nicknameSearchBtn.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 0.5), for: .normal)
        doodleSearchBtn.titleLabel?.layer.shadowColor = UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0).cgColor
        doodleSearchBtn.setTitleColor(UIColor.init(red: 68.0/255.0, green: 80.0/255.0, blue: 97.0/255.0, alpha: 1.0), for: .normal)
        flag = 1
    } //#445061 -> 68 / 80 / 97,  #464646 -> 70 / 70 / 70
    @IBAction func cancelBtnAction(_ sender: Any) {
        searchTxtFd.text = ""
        cancelBtn.isEnabled = false
        cancelBtn.isHidden = true
        searchResultVO.removeAll(keepingCapacity: false)
        searchTableView.reloadData()
        searchCollectionView.reloadData()
    }
    
    @objc func searchTextField() {
        if (searchTxtFd.text?.isEmpty)! {
            cancelBtn.isHidden = true
            cancelBtn.isEnabled = false
            searchResultVO.removeAll(keepingCapacity: false)
            searchTableView.reloadData()
            searchCollectionView.reloadData()
        } else {
            cancelBtn.isHidden = false
            cancelBtn.isEnabled = true
            let model = AppreciateManager(self)
            let keyword = gsno(searchTxtFd.text)
            print(keyword)
            model.search(flag: flag, keyword: keyword, token: gsno(token))
        }
        
    }
    
}
extension SearchVC : NetworkCallBack {
    
    func networkResultData(resultData: Any, code: String) {
        if code == "search" {
            searchResultVO = resultData as! [SearchResultVO]
            if flag == 0{
                searchTableView.reloadData()
            }
            else {
                searchCollectionView.reloadData()
            }
        }
    }
}


extension SearchVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultVO.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath) as! SearchTableCell
        let searchResult = searchResultVO[indexPath.row]
        cell.profileImage.imageFromUrl(gsno(searchResult.image), defaultImgPath: "")
        cell.nickname.text = searchResult.nickname
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dvc = storyboard?.instantiateViewController(withIdentifier: "userpost") as? UserPostViewController else { return }
        let searchResult = searchResultVO[indexPath.row]
        dvc.userindex = gino(searchResult.idx)
        navigationController?.pushViewController(dvc, animated: true)
    }
    
    
    
}
extension SearchVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultVO.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionCell", for: indexPath) as! SearchCollectionCell
        let searchResult = searchResultVO[indexPath.item]
        cell.image.imageFromUrl(gsno(searchResult.image), defaultImgPath: "")
        return cell
    }
    
    
}
