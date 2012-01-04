//
//  ImageViewController.h
//  imgurtest
//
//  Created by ipass on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSURL *imageURL;
    dispatch_queue_t backgroundQueue;
    NSDictionary *imageDictionaty;
    NSArray *imageCaptionsArray;
    UITextView *imageTitle;
    NSArray *imagesInPage;
    NSInteger currentImageNumber;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITableView *captionsTableView;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSDictionary *imageDictionary;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *votesBar;
@property (strong, nonatomic) NSArray *imagesInPage;
@property (nonatomic) NSInteger currentImageNumber;

- (void)createVotesBarWithUps:(int)ups andDowns:(int)downs;

@end
