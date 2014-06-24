//
//  PhotoViewController.swift
//  shuttershare
//
//  Created by Yosub Shin on 6/15/14.
//  Copyright (c) 2014 yosubshin. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var scrollView : UIScrollView
    var imageView: UIImageView = UIImageView()
    var photo: Photo!
    var group: Group?
    var image: UIImage {
    get {
        return imageView.image
    }
    set {
        self.imageView.image = newValue
        self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height)
    }
    }

    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if group {
            let member = group!.getMember(self.photo.user_id)
            self.title = member!.name
        }

        self.scrollView.contentSize = self.image.size
        self.scrollView.minimumZoomScale = 0.1
        self.scrollView.maximumZoomScale = imageView.image.size.width / scrollView.frame.size.width
        self.scrollView.delegate = self
        
        self.scrollView.addSubview(self.imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return self.imageView
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
