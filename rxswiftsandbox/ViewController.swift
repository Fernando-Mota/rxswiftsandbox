//
//  ViewController.swift
//  rxswiftsandbox
//
//  Created by Fernando Mota e Silva on 24/10/17.
//  Copyright © 2017 Fernando Mota e Silva. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class Todo {
    
    let descricao: String
    
    init (descricao: String) {
        self.descricao = descricao
    }
}


class ViewController: UIViewController {
    
    var shownCities = [String]()
    
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga", "Rio de Janeiro", "São Paulo"]
    
    let disposeBag = DisposeBag();

    @IBOutlet weak var search: UISearchBar!
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        
        search
            .rx
            .text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter{value in !value.isEmpty}
            .subscribe(onNext: { [unowned self] query in
                self.shownCities = self.allCities.filter { $0.hasPrefix(query) }
                self.table.reloadData()
            })
            .disposed(by: disposeBag)
        
        flatMapSample()
    }
    
    
    func flatMapSample() {
        
        let nomes = ["Fernando", "Andressa 1", "Ana"]
        
        let todos = [Todo(descricao: "Descricao 1"), Todo(descricao: "Descricao 2"), Todo(descricao: "Descricao 3")]
        
        let mainScheduler = MainScheduler.instance
        let backgroundScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        
        Observable.of(Observable.from(optional: todos), Observable.from(nomes).flatMap{
            values in
            Observable.from(optional: values)
            }.map{value in
                Todo(descricao: value)
            }.toArray().asObservable()).merge()
            .flatMap{values in
                Observable.from(values)
            }
            .subscribeOn(backgroundScheduler)
            .map{value in
                print("Subscribe aqui \(Thread.isMainThread))")
                return value.descricao}
            .filter{
                value in
                return value.contains("1")
            }.observeOn(mainScheduler)
            .map{value in Todo(descricao: value)}
            .subscribe(onNext: {
                values in
                print("Subscribe aqui 666 \(Thread.isMainThread))")
                print(values.descricao)
            }).disposed(by: disposeBag)
    }
    
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        return cell
    }
}

