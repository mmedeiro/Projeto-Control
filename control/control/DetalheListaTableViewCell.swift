//
//  DetalheListaTableViewCell.swift
//  control
//
//  Created by Mariana Medeiro on 17/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class DetalheListaTableViewCell: UITableViewCell {

    @IBOutlet weak var qtdProduto: UILabel!
    @IBOutlet weak var valorProduto: UILabel!
    @IBOutlet weak var nomeProduto: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
