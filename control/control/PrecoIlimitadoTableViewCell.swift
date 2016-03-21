//
//  PrecoIlimitadoTableViewCell.swift
//  control
//
//  Created by Amanda Campos on 11/03/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import UIKit

class PrecoIlimitadoTableViewCell: UITableViewCell {

    @IBOutlet weak var nomeItemIlimitado: UILabel!
    
    @IBOutlet weak var precoItemIlimitado: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
