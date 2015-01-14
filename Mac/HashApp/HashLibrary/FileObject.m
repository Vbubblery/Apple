//
//  FileObject.m
//  Hash
//
//  Created by juncheng zhou on 5/24/14.
//
//

#import "FileObject.h"

@implementation FileObject
@synthesize Path,Hash;
-(id)initWithPath:(NSString *)lpath andHash:lHash;{
    self=[super init];
    if (self) {
        Path=lpath;
        Hash=lHash;
    }
    return self;
}
@end
