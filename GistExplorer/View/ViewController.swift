//
//  ViewController.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 29/07/24.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel: GistListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
        setupViewModel()
    }

    private func setupViewModel() {
        // Inicialize a ViewModel
        viewModel = GistListViewModel()

        // Configurar bindings ou callbacks se necessário
        viewModel?.fetchGists()
    }


}

extension ViewController: ViewConfiguration {
    func setupConstraints() {

    }
    
    func buildViewHierarchy() {

    }
    

}

