//
// XMLReader.h
//

#import <Foundation/Foundation.h>

@interface XMLReader : NSObject<NSXMLParserDelegate>
{
    NSMutableArray *rootArray;
    NSMutableString *textInProgress;
    NSError *errorPointer;
    NSString *searchItem;
}
@property (strong, nonatomic) NSString *searchItem;

+ (NSArray *)dictionaryForXMLData:(NSData *)data error:(NSError *)errorPointer;



@end
