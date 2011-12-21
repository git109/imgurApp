//
//  CaptionsCell.h
//  imgurtest
//
//  Created by almas daumov on 12/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaptionsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UITextView *captionsTextView;

@end
