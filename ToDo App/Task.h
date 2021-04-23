//
//  Task.h
//  ToDo App
//
//  Created by Mohamed Abdallah on 4/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject<NSCoding>

@property NSString *name , *desc , *priority , *state;
@property NSDate *reminderDate,*creationDate;

-(void) encodeWithCoder:(NSCoder *)coder;

-(id) initWithCoder:(NSCoder *)decoder;


@end

NS_ASSUME_NONNULL_END
