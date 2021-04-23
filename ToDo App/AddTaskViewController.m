//
//  AddTaskViewController.m
//  ToDo App
//
//  Created by Mohamed Abdallah on 4/5/21.
//

#import "AddTaskViewController.h"
#import "Task.h"

@interface AddTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextView *taskDetails;
@property (weak, nonatomic) IBOutlet UIDatePicker *taskDate;
@property (weak, nonatomic) IBOutlet UIPickerView *taskPriority;

@end

@implementation AddTaskViewController{
    Task *oneTask;
    NSString *selectedPriority;
    NSMutableArray *prioritylist;
    NSMutableArray *todoArray;
    NSMutableArray *aaa;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    prioritylist =[NSMutableArray new];
    [prioritylist addObject:@"High"];
    [prioritylist addObject:@"Mid"];
    [prioritylist addObject:@"Low"];
    
    selectedPriority=@"Low";
    _taskDetails.text=@"";

    [_taskPriority setDelegate:self] ;
    [_taskPriority setDataSource:self] ;
    todoArray =[NSMutableArray new];
    aaa =[NSMutableArray arrayWithCapacity:todoArray.count];
    
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes :types categories :nil];
    [[ UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    

}


- (IBAction)addTaskAction:(id)sender {
    
    [[
        UIApplication
        sharedApplication
        ]
     cancelAllLocalNotifications];

    
    oneTask =[Task new];

    oneTask.name = _taskName.text;
    oneTask.desc = _taskDetails.text;
    oneTask.priority = selectedPriority;
    oneTask.reminderDate = _taskDate.date;
    oneTask.creationDate = [NSDate date];
    oneTask.state=@"ToDo";
    

    NSData  *a=[[NSUserDefaults standardUserDefaults]objectForKey:@"TODO"];
    todoArray=[NSKeyedUnarchiver unarchiveObjectWithData:a];
    

    [todoArray addObject:oneTask];
    NSData *data=[NSKeyedArchiver archivedDataWithRootObject:todoArray requiringSecureCoding:NO error:nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"TODO"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    //
    
    NSTimeInterval interval;
    interval =60 *60     *12  ;//12 hours from now
    UILocalNotification  * localNotification = [[ UILocalNotification  alloc ] init];
    localNotification.fireDate= [NSDate  dateWithTimeIntervalSinceNow : _taskDate.date.timeIntervalSinceNow];
    //Enter the time here in seconds.
    localNotification. alertBody = @"Your Task will be in progress mode";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification. repeatInterval = NSCalendarUnitMinute;
    //NSCalendarUnitMinute;
    //NSCalendarUnitDay
    //Repeating instructions here.
    localNotification.soundName= UILocalNotificationDefaultSoundName ;
    [[ UIApplication  sharedApplication] scheduleLocalNotification  :localNotification];
    
    
    //
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
 
    return 1 ;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [prioritylist count] ;

}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
        selectedPriority = prioritylist[row] ;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return prioritylist[row] ;
    
}

@end
