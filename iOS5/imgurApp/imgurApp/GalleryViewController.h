//
//  GalleryViewController.h
//  imgurApp
//
//  Created by almas daumov on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GalleryPagesController.h"

@interface GalleryViewController : UIViewController <UIScrollViewDelegate> {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    
    NSMutableArray *_viewControllers;
    BOOL pageControlUsed;
    int numberOfPages;
    
    NSArray *pagesData;
    
    IBOutlet UIButton *topWeekButton;
    IBOutlet UIButton *topMonthButton;
    IBOutlet UIButton *topAllTimeButton;
    IBOutlet UIButton *hotButton; // button on the top
    IBOutlet UIButton *topButton; // button on the top
    
}

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *viewControllers;

- (IBAction)changePage:(id)sender;
- (void)loadScrollViewWithPage:(int)page;
- (NSMutableArray *)getDataForGalleryPageUrl:(NSURL *)pageUrl;
- (void)loadGalleryWithUrl:(NSURL *)url;

- (void)showTopWeekPage:(int)page;
- (void)showTopMonthPage:(int)page;
- (void)showTopAllTimePage:(int)page;
- (void)showHotPage:(int)page;


- (IBAction)topWeekButtonTapped;
- (IBAction)topMonthButtonTapped;
- (IBAction)topAllButtonTapped;
- (IBAction)hotButtonTapped;


@end
