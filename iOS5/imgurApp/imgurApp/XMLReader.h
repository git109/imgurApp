//
// XMLReader.h
//

#import <Foundation/Foundation.h>

@interface XMLReader : NSObject<NSXMLParserDelegate>
{
    NSMutableArray *rootArray;
    NSMutableString *textInProgress;
    NSError *errorPointer;

}

+ (NSArray *)dictionaryForXMLData:(NSData *)data error:(NSError *)errorPointer;
+ (NSArray *)dictionaryForXMLString:(NSString *)string error:(NSError *)errorPointer;

-(id)initWithError:(NSError *)error;
-(NSArray*)objectWithData:(NSData *)data;

@end
