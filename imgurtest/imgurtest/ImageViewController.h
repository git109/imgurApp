//
//  ImageViewController.h
//  imgurtest
//
//  Created by ipass on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UITableView *tableView;
    NSURL *imageURL;
    dispatch_queue_t backgroundQueue;
    
    // test
    NSDictionary *imageDictionaty;
    IBOutlet UIWebView *webView;

}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSURL *imageURL;

//test
@property (strong, nonatomic) NSDictionary *imageDictionary;

@end
