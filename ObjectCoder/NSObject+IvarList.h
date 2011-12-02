//
//  NSObject+IvarList.h
//  ObjectCoderTest
//
//  Created by Alex Nichol on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#define OCIvarNotFoundException @"OCIvarNotFoundException"

#include <objc/runtime.h>
#import <Foundation/Foundation.h>
#import "OCIvarInfo.h"

@interface NSObject (IvarList)

/**
 * @return An array of OCIvarInfo objects. If no instance variables exist
 * on this object, an empty array is returned.
 */
- (NSArray *)instanceVariables;

- (Ivar)getInstanceVariable:(NSString *)ivarName;
- (id)getInstanceVariableObject:(NSString *)ivarName;

- (char)getInstanceVariableChar:(NSString *)ivarName;
- (short)getInstanceVariableShort:(NSString *)ivarName;
- (int)getInstanceVariableInt:(NSString *)ivarName;
- (long)getInstanceVariableLong:(NSString *)ivarName;
- (long long)getInstanceVariableLongLong:(NSString *)ivarName;

- (unsigned char)getInstanceVariableUnsignedChar:(NSString *)ivarName;
- (unsigned short)getInstanceVariableUnsignedShort:(NSString *)ivarName;
- (unsigned int)getInstanceVariableUnsignedInt:(NSString *)ivarName;
- (unsigned long)getInstanceVariableUnsignedLong:(NSString *)ivarName;
- (unsigned long long)getInstanceVariableUnsignedLongLong:(NSString *)ivarName;

- (_Bool)getInstanceVariableBool:(NSString *)ivarName;
- (void *)getInstanceVariablePointer:(NSString *)ivarName;

@end
