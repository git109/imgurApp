//
//  GalleryViewController.m
//  imgurApp
//
//  Created by almas daumov on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GalleryViewController.h"
#import "XMLReader.h"


@implementation GalleryViewController
@synthesize scrollView, pageControl;
@synthesize viewControllers = _viewControllers;

#pragma mark - View lifecycle

/****************************************************************************************************
 * This method returns the data for the website gallery page, not the application '9 images page'   *
 ****************************************************************************************************/
-(NSArray *)getDataForGalleryPageUrl:(NSURL *)pageUrl {
    NSData *data = [NSData dataWithContentsOfURL:pageUrl];
    NSLog(@"data size: %d", [data length]);
    NSArray *pageData = [XMLReader dictionaryForXMLData:data error:nil];
    return pageData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // The gallery loads with http://imgur.com/gallery/hot/page/0 by default  
    
    // Calculating the number of pages to create in the scroll view
    NSURL *url = [NSURL URLWithString:@"http://imgur.com/gallery/hot/page/0.xml"];
 /*   pagesData = [self getDataForGalleryPageUrl:url];
    if ([pagesData count] % 9 == 0) {
        numberOfPages = [pagesData count] / 9;
    }
    else numberOfPages = ([pagesData count] / 9) + 1;
        
    NSLog(@"total number of images: %d", [pagesData count]);
    
    // Creating '9 image' views in the scroll view
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < numberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * numberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = numberOfPages;
    pageControl.currentPage = 0;
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];*/
    [self loadGalleryWithUrl:url];
}

- (void)loadGalleryWithUrl:(NSURL *)url {
    pagesData = [self getDataForGalleryPageUrl:url];
    if ([pagesData count] % 9 == 0) {
        numberOfPages = [pagesData count] / 9;
    }
    else numberOfPages = ([pagesData count] / 9) + 1;
    
    NSLog(@"total number of images: %d", [pagesData count]);
    
    // Creating '9 image' views in the scroll view
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < numberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * numberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = numberOfPages;
    pageControl.currentPage = 0;
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
}


- (IBAction)showTopWeek:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://imgur.com/gallery/top/week.xml"];
    [self loadGalleryWithUrl:url];
}

- (IBAction)showTopMonth:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://imgur.com/gallery/top/month.xml"];
    [self loadGalleryWithUrl:url];
}

- (IBAction)showTopAllTime:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://imgur.com/gallery/top/all.xml"];
    [self loadGalleryWithUrl:url];
}














- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= numberOfPages) return;
    
    GalleryPagesController *controller = [self.viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[GalleryPagesController alloc] initWithPageNumber:page andData:pagesData];
        [self.viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    if (nil == controller.view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
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
- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    pageControlUsed = YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
