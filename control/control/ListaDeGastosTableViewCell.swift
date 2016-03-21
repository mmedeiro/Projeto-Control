//
//  ListaDeGastosTableViewCell.swift
//  control
//
//  Created by Amanda Campos on 14/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class ListaDeGastosTableViewCell: UITableViewCell {

    @IBOutlet weak var nomeDaLista: UILabel!
    @IBOutlet weak var totalDaLista: UILabel!
    @IBOutlet weak var dataDaLista: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
