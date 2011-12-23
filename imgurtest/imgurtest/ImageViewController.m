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
@synthesize webView;
@synthesize titleLabel;
@synthesize votesBar;



- (void)viewDidLoad
{
    [super viewDidLoad];
    backgroundQueue = dispatch_queue_create("com.almas.imgur", NULL);   
    
    
    // Create the label
    NSString *titleText = [NSString stringWithFormat:@"%@", [self.imageDictionary valueForKey:@"title"]];
    NSLog(@"%@", titleText);
    titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = UITextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    titleLabel.text = titleText;
    //Calculate the expected size based on the font and linebreak mode of label
    CGSize maximumLabelSize = CGSizeMake(300,9999);
    CGSize expectedLabelSize = [titleText sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:maximumLabelSize lineBreakMode:titleLabel.lineBreakMode];
    
    //Adjust the label the the new height
    CGRect newFrame = CGRectMake(10, 0, 300, expectedLabelSize.height);
    NSLog(@"%f", expectedLabelSize.height);
    titleLabel.frame = newFrame;
    [self.scrollView addSubview:titleLabel];
    
    // Set webView position
    CGRect scrollViewRect = CGRectMake(0, titleLabel.frame.size.height, 320, 287);
    [self.webView setFrame:scrollViewRect];
    
    // Set tableView position
    CGRect tableViewRect = CGRectMake(0, self.webView.frame.origin.y+self.webView.frame.size.height+30, 320, 400);
    [self.captionsTableView setFrame:tableViewRect];
    
    // Set scrollView Contents Size
    [self.scrollView setContentSize:CGSizeMake(320, self.titleLabel.frame.size.height+self.webView.frame.size.height+self.captionsTableView.frame.size.height-15)];
    
    [self createVotesBarWithUps:[[self.imageDictionary valueForKey:@"ups"] intValue] andDowns:[[self.imageDictionary valueForKey:@"downs"] intValue]];
    
    imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://i.imgur.com/%@%@", [self.imageDictionary valueForKey:@"hash"], [self.imageDictionary valueForKey:@"ext"]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    [webView loadRequest:request];
    
    NSString *string = [NSString stringWithFormat:@"http://imgur.com/gallery/%@.xml", [self.imageDictionary valueForKey:@"hash"]];
    NSURL *url = [NSURL URLWithString:string];
    NSData *data = [NSData dataWithContentsOfURL:url];
    imageCaptionsArray = [XMLReader dictionaryForXMLData:data error:nil];
}

- (void)createVotesBarWithUps:(int)ups andDowns:(int)downs {
    votesBar = [[UIView alloc] initWithFrame:CGRectMake(40, self.webView.frame.origin.y+self.webView.frame.size.height+5, 240, 20)];
    votesBar.backgroundColor = [UIColor yellowColor];
    
    NSLog(@"%d %d", ups, downs);
    
    
    
    
    
    
    
    
    
    
    [self.scrollView addSubview:votesBar];
}

#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [imageCaptionsArray count];
}


- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = [NSString stringWithFormat:@"%@:  %@", [[imageCaptionsArray objectAtIndex:indexPath.row] objectForKey:@"author"], [[imageCaptionsArray objectAtIndex:indexPath.row] objectForKey:@"caption"]];
    CGSize expectedLabelSize = [text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(300,9999) lineBreakMode:UILineBreakModeWordWrap];
    return expectedLabelSize.height+10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CaptionsCell *cell = [[CaptionsCell alloc] init];
    NSString *text = [NSString stringWithFormat:@"%@:  %@", [[imageCaptionsArray objectAtIndex:indexPath.row] objectForKey:@"author"], [[imageCaptionsArray objectAtIndex:indexPath.row] objectForKey:@"caption"]];
   
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 20)];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.text = text;
    
    //Calculate the expected size based on the font and linebreak mode of label
    CGSize maximumLabelSize = CGSizeMake(300,9999);
    CGSize expectedLabelSize = [text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    
    //Adjust the label the the new height
    CGRect newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    label.frame = newFrame;
    
    [cell addSubview:label];

    return cell;
}

#pragma mark - View lifecycle

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
