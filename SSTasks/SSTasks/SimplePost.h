//
//  SimplePost.h
//  SimplePost
//
//  Created by Nicolas Goles on 10/12/11.
//  Licensed under the MIT license
//

#import <Foundation/Foundation.h>

@interface SimplePost : NSObject

+ (NSMutableURLRequest *) multipartRequestWithURL:(NSURL *)url andDataDictionary:(NSDictionary *) dictionary;
+ (NSMutableURLRequest *) urlencodedRequestWithURL:(NSURL *)url andDataDictionary:(NSDictionary *) dictionary;

@end
