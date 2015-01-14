//
//  FileObject.h
//  Hash
//
//  Created by juncheng zhou on 5/24/14.
//
//

#import <Foundation/Foundation.h>

@interface FileObject : NSObject
@property (weak,nonatomic,readonly) NSString* Path;
@property(weak,nonatomic,readonly) NSString* Hash;
-(id)initWithPath:(NSString *)lpath andHash:lHash;
@end
