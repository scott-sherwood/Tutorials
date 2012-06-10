//
//  SimplePost.m
//  SimplePost
//
//  Created by Nicolas Goles on 10/12/11.
//  Licensed under the MIT license
//

#import "SimplePost.h"

@implementation SimplePost

/** Creates a multipart HTTP POST request.
 *  @param url is the target URL for the POST request
 *  @param dictionary is a key/value dictionary with the DATA of the multipart post.
 *  
 *  Should be constructed like:
 *      NSArray *keys = [[NSArray alloc] initWithObjects:@"login", @"password", nil];
 *      NSArray *objects = [[NSArray alloc] initWithObjects:@"TheLoginName", @"ThePassword!", nil];    
 *      NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
 */
+ (NSMutableURLRequest *) multipartRequestWithURL:(NSURL *)url andDataDictionary:(NSDictionary *) dictionary
{
    // Create POST request
    NSMutableURLRequest *mutipartPostRequest = [NSMutableURLRequest requestWithURL:url];
    [mutipartPostRequest setHTTPMethod:@"POST"];
    
    // Add HTTP header info
    // Note: POST boundaries are described here: http://www.vivtek.com/rfc1867.html
    // and here http://www.w3.org/TR/html4/interact/forms.html
    NSString *POSTBoundary = [NSString stringWithString:@"0xHttPbOuNdArY"]; // You could calculate a better boundary here.
    [mutipartPostRequest addValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", POSTBoundary] forHTTPHeaderField:@"Content-Type"];
    
    // Add HTTP Body
    NSMutableData *POSTBody = [NSMutableData data];
    [POSTBody appendData:[[NSString stringWithFormat:@"--%@\r\n",POSTBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Add Key/Values to the Body
    NSEnumerator *enumerator = [dictionary keyEnumerator];
    NSString *key;
    
    while ((key = [enumerator nextObject])) {
        [POSTBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [POSTBody appendData:[[NSString stringWithFormat:@"%@", [dictionary objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
        
        if ([enumerator nextObject] != nil) {
            [POSTBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", POSTBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    // Add the closing -- to the POST Form
    [POSTBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", POSTBoundary] dataUsingEncoding:NSUTF8StringEncoding]]; 
    
    // Add the body to the mutipartPostRequest & return
    [mutipartPostRequest setHTTPBody:POSTBody];
    return mutipartPostRequest;
}

/** Creates a form-urlencoded HTTP POST request.
 *  @param url is the target URL for the POST request
 *  @param dictionary is a key/value dictionary with the DATA of the multipart post.
 *  
 *  Should be constructed like:
 *      NSArray *keys = [[NSArray alloc] initWithObjects:@"login", @"password", nil];
 *      NSArray *objects = [[NSArray alloc] initWithObjects:@"TheLoginName", @"ThePassword!", nil];    
 *      NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
 */
+ (NSMutableURLRequest *) urlencodedRequestWithURL:(NSURL *)url andDataDictionary:(NSDictionary *) dictionary
{
    //  Create POST request
    NSMutableURLRequest *urlencodedPostRequest = [NSMutableURLRequest requestWithURL:url];
    [urlencodedPostRequest setHTTPMethod:@"POST"];
    
    //  Add HTTP header info
    [urlencodedPostRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    //  Add POST body
    NSMutableData *POSTBody = [NSMutableData data];
    
    //  Add k/v to the body
    NSArray *keyArray =  [dictionary allKeys];
    for (int i = 0; i < [keyArray count]; ++i) {        
        // Core Foundation function used to transform @ ==> %40 , etc
        NSString *escapedString = (__bridge NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, 
                                                                                                (__bridge CFStringRef)([dictionary objectForKey:[keyArray objectAtIndex:i]]),
                                                                                                NULL, 
                                                                                                (CFStringRef)@"!*'();:@&=+$,/?%#[]", 
                                                                                                kCFStringEncodingUTF8);
        
        [POSTBody appendData:[[NSString stringWithFormat:@"%@=%@", [keyArray objectAtIndex:i], escapedString] dataUsingEncoding:NSUTF8StringEncoding]];
        
        if (i < ([keyArray count] - 1)) {
            [POSTBody appendData:[[NSString stringWithFormat:@"&"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    [urlencodedPostRequest setHTTPBody:POSTBody];
    return urlencodedPostRequest;
}

@end
