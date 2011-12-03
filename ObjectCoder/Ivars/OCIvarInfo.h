//
//  OCIvarInfo.h
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCIvarInfo : NSObject {
	NSString * name;
	NSString * typeEncoding;
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * typeEncoding;

- (id)initWithName:(NSString *)aName typeEncoding:(NSString *)aTypeEncoding;
+ (OCIvarInfo *)ivarInfoWithName:(NSString *)aName typeEncoding:(NSString *)anEncodingType;

@end
