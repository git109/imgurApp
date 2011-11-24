//
//  GalleryPagesController.h
//  Imgur
//
//  Created by almas daumov on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GalleryPagesController : UIViewController {
    IBOutlet UILabel *pageNumberLabel;
    int pageNumber;
    
}
@property (nonatomic, retain) UILabel *pageNumberLabel;

- (id)initWithPageNumber:(int)page;

@end
