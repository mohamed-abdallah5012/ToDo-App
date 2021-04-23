//
//  Task.m
//  ToDo App
//
//  Created by Mohamed Abdallah on 4/2/21.
//

#import "Task.h"

@implementation Task

@synthesize name,desc,priority,state;
@synthesize reminderDate,creationDate;



- (void)encodeWithCoder:(NSCoder *)coder
{
    //[super encodeWithCoder:coder];
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.desc forKey:@"desc"];
    [coder encodeObject:self.priority forKey:@"priority"];
    [coder encodeObject:self.state forKey:@"state"];
    [coder encodeObject:self.creationDate forKey:@"creationDate"];
    [coder encodeObject:self.reminderDate forKey:@"reminderDate"];
    
    
}
- (instancetype)initWithCoder:(NSCoder *)decoder
{
   // self = [super initWithCoder:coder];
    if (self =[super init]) {
        self.name=[decoder decodeObjectForKey:@"name"];
        self.desc=[decoder decodeObjectForKey:@"desc"];
        self.priority=[decoder decodeObjectForKey:@"priority"];
        self.state=[decoder decodeObjectForKey:@"state"];
        self.creationDate=[decoder decodeObjectForKey:@"creationDate"];
        self.reminderDate=[decoder decodeObjectForKey:@"reminderDate"];
    }
    return self;
}

@end
