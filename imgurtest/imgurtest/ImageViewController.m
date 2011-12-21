//
//  ImageViewController.m
//  imgurtest
//
//  Created by ipass on 12/16/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageViewController.h"
#import <dispatch/dispatch.h>
#import "CaptionsCell.h"
#import "XMLReader.h"


@implementation ImageViewController
@synthesize scrollView;
@synthesize captionsTableView;
@synthesize imageURL;
@synthesize imageDictionary;
@synthesize imageTitle;



- (void)viewDidLoad
{
    [super viewDidLoad];
    backgroundQueue = dispatch_queue_create("com.almas.imgur", NULL);        
    
    [self.imageTitle setText:[NSString stringWithFormat:@"%@", [self.imageDictionary valueForKey:@"title"]]];
    [self.scrollView setContentSize:CGSizeMake(320, 640)];
    imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://i.imgur.com/%@%@", [self.imageDictionary valueForKey:@"hash"], [self.imageDictionary valueForKey:@"ext"]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    [webView loadRequest:request];
    
    
    
    NSString *string = [NSString stringWithFormat:@"http://imgur.com/gallery/%@.xml", [self.imageDictionary valueForKey:@"hash"]];
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    imageCaptionsArray = [XMLReader dictionaryForXMLData:data error:nil];
    
    
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [imageCaptionsArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 65.0;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CaptionsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CaptionsCell"];
    
    [cell.userNameLabel setText:[[imageCaptionsArray objectAtIndex:indexPath.row] objectForKey:@"author"]];
    [cell.captionsTextView setText:[[imageCaptionsArray objectAtIndex:indexPath.row] objectForKey:@"caption"]];

    return cell;
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/




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
