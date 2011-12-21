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
    IBOutlet UITableView *captionsTableView;
    NSURL *imageURL;
    dispatch_queue_t backgroundQueue;
    
    // test
    NSDictionary *imageDictionaty;
    NSArray *imageCaptionsArray;
    IBOutlet UIWebView *webView;
    UITextView *imageTitle;

}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITableView *captionsTableView;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) IBOutlet UITextView *imageTitle;

//test
@property (strong, nonatomic) NSDictionary *imageDictionary;

@end
