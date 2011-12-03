//
//  OCPrimitiveEncode.h
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+IvarList.h"

BOOL OCTypeEncodingIsObject (NSString * type);
BOOL OCIvarIsPrimitive (OCIvarInfo * anIvar);

NSDictionary * OCEncodePrimitive (NSString * className, NSString * type, id pvalue);
NSDictionary * OCEncodePrimitiveIvar (NSObject * object, OCIvarInfo * anIvar);
BOOL OCDecodeAndSetPrimitiveIvar (id object, NSString * ivarName, NSDictionary * ivarInfo);

NSNumber * OCNumberFromPtr (void * ptr);
void * OCPtrFromNumber (NSNumber * number);
