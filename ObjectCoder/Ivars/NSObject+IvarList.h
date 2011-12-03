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

- (float)getInstanceVariableFloat:(NSString *)ivarName;
- (double)getInstanceVariableDouble:(NSString *)ivarName;

- (_Bool)getInstanceVariableBool:(NSString *)ivarName;
- (void *)getInstanceVariablePointer:(NSString *)ivarName;

- (void)setInstanceVariable:(NSString *)ivarName withObject:(id)anObject;

- (void)setInstanceVariable:(NSString *)ivarName withChar:(char)aScalar;
- (void)setInstanceVariable:(NSString *)ivarName withShort:(short)aScalar;
- (void)setInstanceVariable:(NSString *)ivarName withInt:(int)aScalar;
- (void)setInstanceVariable:(NSString *)ivarName withLong:(long)aScalar;
- (void)setInstanceVariable:(NSString *)ivarName withLongLong:(long long)aScalar;

- (void)setInstanceVariable:(NSString *)ivarName withUnsignedChar:(unsigned char)aScalar;
- (void)setInstanceVariable:(NSString *)ivarName withUnsignedShort:(unsigned short)aScalar;
- (void)setInstanceVariable:(NSString *)ivarName withUnsignedInt:(unsigned int)aScalar;
- (void)setInstanceVariable:(NSString *)ivarName withUnsignedLong:(unsigned long)aScalar;
- (void)setInstanceVariable:(NSString *)ivarName withUnsignedLongLong:(unsigned long long)aScalar;

- (void)setInstanceVariable:(NSString *)ivarName withFloat:(float)aScalar;
- (void)setInstanceVariable:(NSString *)ivarName withDouble:(double)aScalar;

- (void)setInstanceVariable:(NSString *)ivarName withBool:(_Bool)aScalar;
- (void)setInstanceVariable:(NSString *)ivarName withPointer:(void *)aScalar;

@end
