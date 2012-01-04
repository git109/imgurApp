//
//  SecondViewController.m
//  imgurtest
//
//  Created by ipass on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GalleryViewController.h"
#import "ImageViewController.h"
#import "DataGetter.h"
#import <dispatch/dispatch.h>

@interface GalleryViewController (hidden)
- (void)createButtons;
- (void)loadAndSetImages;
- (void)loadScrollViewWithPage:(int)page;
@end

@implementation GalleryViewController
@synthesize scrollView;
@synthesize pageControl;
@synthesize viewControllers;
@synthesize hotButton, topWeekButton, topMonthButton, topAllButton;

#pragma mark - View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];  
    backgroundQueue = dispatch_queue_create("com.almas.imgur", NULL);        

    dispatch_async(backgroundQueue, ^(void) {
        pagesData = [DataGetter getHotForPage:0];

        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self reloadGallery];
        });
    });
}

- (void)reloadGallery {
    if ([pagesData count] % 9 == 0) numberOfScrollViewPages = [pagesData count] / 9;
    else numberOfScrollViewPages = ([pagesData count] / 9) + 1;
    
    NSLog(@"total number of images: %d", [pagesData count]);
    
    // Creating '9 image' views in the scroll view
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < numberOfScrollViewPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * numberOfScrollViewPages, 320);
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = numberOfScrollViewPages;
    pageControl.currentPage = 0;
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= numberOfScrollViewPages) return;

    UIView *subview = [self.viewControllers objectAtIndex:page];
  
    if ((NSNull *)subview == [NSNull null]) {
        NSLog(@"Creating subview");
        CGRect frame;
        frame.origin.x = self.scrollView.frame.size.width * page;
        frame.origin.y = 0;
        frame.size = self.scrollView.frame.size;
        
        subview = [[UIView alloc] initWithFrame:frame];

        
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 100, 100)];
        [button1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button1 setEnabled:NO];
        
        
        UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(110, 5, 100, 100)];
        [button2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button2 setEnabled:NO];
        
        UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(215, 5, 100, 100)];
        [button3 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button3 setEnabled:NO];
        
        UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(5, 110, 100, 100)];
        [button4 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button4 setEnabled:NO];

        UIButton *button5 = [[UIButton alloc] initWithFrame:CGRectMake(110, 110, 100, 100)];
        [button5 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button5 setEnabled:NO];
        
        UIButton *button6 = [[UIButton alloc] initWithFrame:CGRectMake(215, 110, 100, 100)];
        [button6 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button6 setEnabled:NO];
        
        UIButton *button7 = [[UIButton alloc] initWithFrame:CGRectMake(5, 215, 100, 100)];
        [button7 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button7 setEnabled:NO];
        
        UIButton *button8 = [[UIButton alloc] initWithFrame:CGRectMake(110, 215, 100, 100)];
        [button8 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button8 setEnabled:NO];
        
        UIButton *button9 = [[UIButton alloc] initWithFrame:CGRectMake(215, 215, 100, 100)];
        [button9 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button9 setEnabled:NO];
        
        
        [subview addSubview:button1];
        [subview addSubview:button2];
        [subview addSubview:button3];
        [subview addSubview:button4];
        [subview addSubview:button5];
        [subview addSubview:button6];
        [subview addSubview:button7];
        [subview addSubview:button8];
        [subview addSubview:button9];
        [self.viewControllers replaceObjectAtIndex:page withObject:subview];
        
        // Downloading images on the background thread
        dispatch_async(backgroundQueue, ^(void) {
            for (int i=0; i<9; i++) {
                if ((page*9)+i < [pagesData count]) {
                    NSData *data;
                    data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://i.imgur.com/%@b%@", [[pagesData objectAtIndex:((page*9)+i)] valueForKey:@"hash"], [[pagesData objectAtIndex:((page*9)+i)] valueForKey:@"ext"]]]];
                    NSLog(@"%@", [NSURL URLWithString:[NSString stringWithFormat:@"http://i.imgur.com/%@b%@", [[pagesData objectAtIndex:((page*9)+i)] valueForKey:@"hash"], [[pagesData objectAtIndex:((page*9)+i)] valueForKey:@"ext"]]]);

                    UIImage *image = [UIImage imageWithData:data];
                    // Setting images on the main thread
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        [[subview.subviews objectAtIndex:i] setImage:image forState:UIControlStateNormal];
                        [[subview.subviews objectAtIndex:i] setEnabled:YES];
                    });
                }
            }
        });
        
    }
    
    if (nil == subview.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        subview.frame = frame;
        [scrollView addSubview:subview];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (pageControlUsed) {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (void)buttonPressed:(id)sender {
    NSLog(@"button pressed");
    
    UIButton *button = (UIButton *)sender;
    
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"page number: %d", page);
    int imageIndex = page*9 + [[[self.scrollView.subviews objectAtIndex:page] subviews] indexOfObject:button];
    NSLog(@"you tapped on image number :%d", imageIndex);
    

    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    ImageViewController *imageController = [storyboard instantiateViewControllerWithIdentifier:@"ImageController"];
    imageController.imageDictionary = [pagesData objectAtIndex:imageIndex];
    imageController.currentImageNumber = imageIndex;
    imageController.imagesInPage = pagesData;

    [self.navigationController pushViewController:imageController animated:YES];
}

- (IBAction)showHot:(id)sender {
    [self.hotButton setEnabled:NO];
    [self.topWeekButton setEnabled:YES];
    [self.topMonthButton setEnabled:YES];
    [self.topAllButton setEnabled:YES];
    [self.navigationItem setTitle:@"Hot"];
    for(UIView *subview in [self.scrollView subviews]) {
        [subview removeFromSuperview];
    }
    CGRect frame = scrollView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControlUsed = YES;
    dispatch_async(backgroundQueue, ^(void) {
        pagesData = [DataGetter getHotForPage:0];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self reloadGallery];
        });
    });
}

- (IBAction)showTopWeek:(id)sender {
    [self.hotButton setEnabled:YES];
    [self.topWeekButton setEnabled:NO];
    [self.topMonthButton setEnabled:YES];
    [self.topAllButton setEnabled:YES];
    [self.navigationItem setTitle:@"Top Week"];
    for(UIView *subview in [self.scrollView subviews]) {
        [subview removeFromSuperview];
    }
    CGRect frame = scrollView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControlUsed = YES;
    dispatch_async(backgroundQueue, ^(void) {
        pagesData = [DataGetter getTopWeekForPage:0];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self reloadGallery];
        });
    });
}

- (IBAction)showTopMonth:(id)sender {
    [self.hotButton setEnabled:YES];
    [self.topWeekButton setEnabled:YES];
    [self.topMonthButton setEnabled:NO];
    [self.topAllButton setEnabled:YES];
    [self.navigationItem setTitle:@"Top Month"];
    for(UIView *subview in [self.scrollView subviews]) {
        [subview removeFromSuperview];
    }
    CGRect frame = scrollView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControlUsed = YES;
    dispatch_async(backgroundQueue, ^(void) {
        pagesData = [DataGetter getTopMonthForPage:0];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self reloadGallery];
        });
    });
}

- (IBAction)showTopAll:(id)sender {
    [self.hotButton setEnabled:YES];
    [self.topWeekButton setEnabled:YES];
    [self.topMonthButton setEnabled:YES];
    [self.topAllButton setEnabled:NO];
    [self.navigationItem setTitle:@"Top All Time"];
    for(UIView *subview in [self.scrollView subviews]) {
        [subview removeFromSuperview];
    }
    CGRect frame = scrollView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControlUsed = YES;
    dispatch_async(backgroundQueue, ^(void) {
        pagesData = [DataGetter getTopAllForPage:0];
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [self reloadGallery];
        });
    });
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
   
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end
