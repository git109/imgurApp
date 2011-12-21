//
//  XMLReader.m
//

#import "XMLReader.h"

NSString *const kXMLReaderTextNodeKey = @"text";

@interface XMLReader (hidden)
-(id)initWithError:(NSError *)error;
-(NSArray*)objectWithData:(NSData *)data;
@end




@implementation XMLReader
@synthesize searchItem;

NSMutableDictionary* childDict;

#pragma mark Public methods

+(NSArray*)dictionaryForXMLData:(NSData *)data error:(NSError *)error
{
    XMLReader *reader = [[XMLReader alloc] initWithError:error];
    reader.searchItem = @"item";
    NSArray *rootArray = [reader objectWithData:data];
    return rootArray;
}



#pragma mark Parsing

- (id)initWithError:(NSError *)error
{
    if (self = [super init])
    {
        errorPointer = error;
    }
    return self;
}


-(NSArray*)objectWithData:(NSData *)data
{
    // Clear out any old data
    rootArray = nil;
    textInProgress = nil;
    
    rootArray = [[NSMutableArray alloc] init];
    textInProgress = [[NSMutableString alloc] init];
    
    // Parse the XML
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    BOOL success = [parser parse];
    
    // Return the stack's root dictionary on success
    if (success){
        return rootArray;
    }
    
    return nil;
}

#pragma mark -
#pragma mark NSXMLParserDelegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if([elementName isEqualToString:self.searchItem])
	{
        childDict = nil;
		childDict = [[NSMutableDictionary alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
//    if([elementName isEqualToString:@"gallery"]){
//    }
//    else 
        if ([elementName isEqualToString:self.searchItem])
    {
    	//Add the dictionary to the array
    	[rootArray addObject:childDict];
    }
    else
    {
        //Add the element to the dictionary
        [childDict setObject:textInProgress forKey:elementName];
        textInProgress = [NSMutableString stringWithFormat:@""];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // Build the text value
    [textInProgress appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    // Set the error pointer to the parser's error object
    errorPointer = parseError;
}

@end