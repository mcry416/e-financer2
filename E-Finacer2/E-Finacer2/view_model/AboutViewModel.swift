//
//  AboutViewModel.swift
//  E-Finacer2
//
//  Created by Eldest's MacBook on 2021/5/19.
//

import Foundation
import UIKit

class AboutViewModel{
    private weak var label: UILabel!
    private weak var button: UIButton!
    
    init(label: UILabel, button: UIButton) {
        self.label = label
        self.button = button
    }
    
    // MARK: - Obsever.
    var labelText: String?{
        get{
            return label.text
        }
        set{
            label.text = newValue
        }
    }
    
    var buttonText: String?{
        get{
            return button.title(for: UIControl.State.normal)
        }
        set{
            button.setTitle(newValue, for: UIControl.State.normal)
        }
    }
    
}

