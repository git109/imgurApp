//
//  GalleryPagesController.m
//  imgurApp
//
//  Created by almas daumov on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GalleryPagesController.h"

@implementation GalleryPagesController
@synthesize pageNumberLabel;
@synthesize imageData = _imageData;

- (id)initWithPageNumber:(int)page andData:(NSArray *)data {
    if (self = [super initWithNibName:@"GalleryPagesController" bundle:nil])    {
        pageNumber = page;
        pagesData = data;
    }
    return self;
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

#pragma mark - View lifecycle

- (void)viewDidLoad {
    pageNumberLabel.text = [NSString stringWithFormat:@"Page %d", pageNumber + 1];
}

- (void)viewDidAppear:(BOOL)animated {
    self.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://i.imgur.com/%@.jpg", [[pagesData objectAtIndex:0] valueForKey:@"hash"]]]];
    UIImage *image = [UIImage imageWithData:self.imageData];
    [_image1 setImage:image];
    
    self.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://i.imgur.com/%@.jpg", [[pagesData objectAtIndex:1] valueForKey:@"hash"]]]];
    image = [UIImage imageWithData:self.imageData];
    [_image2 setImage:image];
    
    self.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://i.imgur.com/%@.jpg", [[pagesData objectAtIndex:2] valueForKey:@"hash"]]]];
    image = [UIImage imageWithData:self.imageData];
    [_image3 setImage:image];
    
    self.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://i.imgur.com/%@.jpg", [[pagesData objectAtIndex:3] valueForKey:@"hash"]]]];
    image = [UIImage imageWithData:self.imageData];
    [_image4 setImage:image];
    
    [_image5 setImage:[_image3 image]];
    [_image6 setImage:[_image3 image]];
    [_image7 setImage:[_image3 image]];
    [_image8 setImage:[_image3 image]];
    [_image9 setImage:[_image3 image]];

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
