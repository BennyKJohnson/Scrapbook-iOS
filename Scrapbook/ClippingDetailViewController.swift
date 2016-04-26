//
//  ClippingDetailViewController.swift
//  Scrapbook
//
//  Created by Benjamin Johnson on 26/04/2016.
//  Copyright © 2016 Benjamin Johnson. All rights reserved.
//

import UIKit

class ClippingDetailViewController: UIViewController {

    var clipping: Clipping!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var notesLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        title = clipping.notes
        
        imageView.image = clipping.image
        notesLabel.text = clipping.notes
        
        let dateFormmater = NSDateFormatter()
        dateFormmater.dateStyle = .MediumStyle
        
        dateLabel.text = "Created at \(dateFormmater.stringFromDate(clipping.createdAt))"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
