//
//  TaskTableViewCell.swift
//  TasksWithSQLite3
//
//  Created by Colby Gatte on 11/15/16.
//  Copyright © 2016 colbyg. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol TaskTableViewCellDelegate {
    func taskTableViewCellDelegate(checkedTaskId: Int)
    func tasktableViewCellDelegate(uncheckedTaskId: Int)
}

class TaskTableViewCell: UITableViewCell {
    
    var task: Task!
    var delegate: TaskTableViewCellDelegate!
    @IBOutlet var checkboxView: BEMCheckBox!
    
    @IBOutlet weak var taskLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        checkboxView.delegate = self
        checkboxView.onAnimationType = BEMAnimationType.fill
        checkboxView.offAnimationType = BEMAnimationType.fill
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
}

extension TaskTableViewCell: BEMCheckBoxDelegate {
    func didTap(_ checkBox: BEMCheckBox) {
        task.toggleStatus()
    }
}
