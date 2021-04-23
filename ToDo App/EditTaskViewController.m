//
//  EditTaskViewController.m
//  ToDo App
//
//  Created by Mohamed Abdallah on 4/5/21.
//

#import "EditTaskViewController.h"

@interface EditTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextView *desc;
@property (weak, nonatomic) IBOutlet UIDatePicker *reminderDate;
@property (weak, nonatomic) IBOutlet UIPickerView *priority;
@property (weak, nonatomic) IBOutlet UIPickerView *state;

@end

@implementation EditTaskViewController
{
    Task *oneTask;
    NSString *selectedPriority;
    NSMutableArray *prioritylist;
    
    
    NSString *selectedState;
    NSMutableArray *statelist;
    NSMutableArray *todoArray;
    NSMutableArray *aaa;

}

- (void)viewWillAppear:(BOOL)animated{
    
    _name.text=_edited.name;
    _desc.text=_edited.desc;
    _reminderDate.date=_edited.reminderDate;
    
    prioritylist =[NSMutableArray new];
    [prioritylist addObject:@"High"];
    [prioritylist addObject:@"Mid"];
    [prioritylist addObject:@"Low"];

    selectedPriority=@"Low";
    

    [_priority setDelegate:self] ;
    [_priority setDataSource:self] ;
    
    
    statelist =[NSMutableArray new];
    if([_edited.state isEqualToString:@"ToDo"])
    {
        [statelist addObject:@"ToDo"];
        [statelist addObject:@"InProgress"];
        [statelist addObject:@"Done"];
    }
   
    else if([_edited.state isEqualToString:@"InProgress"])
    {
        [statelist addObject:@"InProgress"];
        [statelist addObject:@"Done"];
    }
    
    else if([_edited.state isEqualToString:@"Done"])
    {
        [statelist addObject:@"Done"];

    }

    selectedState=@"ToDo";
    

    [_state setDelegate:self] ;
    [_state setDataSource:self] ;
    
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    todoArray =[NSMutableArray new];
    aaa =[NSMutableArray arrayWithCapacity:todoArray.count];
}
- (IBAction)updateTask:(id)sender {
    oneTask =[Task new];

    oneTask.name = _name.text;
    oneTask.desc = _desc.text;
    oneTask.priority = selectedPriority;
    oneTask.reminderDate = _reminderDate.date;
    oneTask.creationDate = [NSDate date];
;
    oneTask.state=selectedState;
    
    if ([_edited.state isEqualToString:@"InProgress"]) {
        NSData  *a=[[NSUserDefaults standardUserDefaults]objectForKey:@"INPROGRESS"];
        todoArray=[NSKeyedUnarchiver unarchiveObjectWithData:a];
       
        for (Task *ress in todoArray)
           {
               if (_edited.name==ress.name) {
                   [todoArray removeObject:ress];
               }
              
           }
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:todoArray requiringSecureCoding:NO error:nil];

        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"INPROGRESS"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    if ([_edited.state isEqualToString:@"Done"]) {
        NSData  *a=[[NSUserDefaults standardUserDefaults]objectForKey:@"DONE"];
        todoArray=[NSKeyedUnarchiver unarchiveObjectWithData:a];
       
        for (Task *ress in todoArray)
           {
               if (_edited.name==ress.name) {
                   [todoArray removeObject:ress];
               }
              
           }
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:todoArray requiringSecureCoding:NO error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"DONE"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    if ([_edited.state isEqualToString:@"ToDo"]) {
        NSData  *a=[[NSUserDefaults standardUserDefaults]objectForKey:@"TODO"];
        todoArray=[NSKeyedUnarchiver unarchiveObjectWithData:a];
       
        for (Task *ress in todoArray)
           {
               if (_edited.name==ress.name) {
                   [todoArray removeObject:ress];
                   printf("ffff");
               }
              
           }
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:todoArray requiringSecureCoding:NO error:nil];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"TODO"];
        [[NSUserDefaults standardUserDefaults]synchronize];

    }
    
    

    if ([selectedState isEqualToString:@"InProgress"]) {
        NSData  *a=[[NSUserDefaults standardUserDefaults]objectForKey:@"INPROGRESS"];
        todoArray=[NSKeyedUnarchiver unarchiveObjectWithData:a];
        
        [todoArray addObject:oneTask];
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:todoArray requiringSecureCoding:NO error:nil];

        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"INPROGRESS"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    if ([selectedState isEqualToString:@"Done"]) {

        NSData  *a=[[NSUserDefaults standardUserDefaults]objectForKey:@"DONE"];
        todoArray=[NSKeyedUnarchiver unarchiveObjectWithData:a];
        
        [todoArray addObject:oneTask];
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:todoArray requiringSecureCoding:NO error:nil];

        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"DONE"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    if ([selectedState isEqualToString:@"ToDo"]) {
        NSData  *a=[[NSUserDefaults standardUserDefaults]objectForKey:@"TODO"];
        todoArray=[NSKeyedUnarchiver unarchiveObjectWithData:a];

        [todoArray addObject:oneTask];
        NSData *data=[NSKeyedArchiver archivedDataWithRootObject:todoArray requiringSecureCoding:NO error:nil];

        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"TODO"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
 
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

return 1 ;

}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSInteger *numOfRows = 0 ;
    switch (pickerView.tag) {
        case 0:
            numOfRows = [prioritylist count]  ;
            break;
        case 1:
            numOfRows = [statelist count]  ;
            break;
    }
    return numOfRows ;

}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (pickerView.tag) {
        case 0:
            selectedPriority = prioritylist[row] ;
            break;
        case 1:
            selectedState=statelist[row];
            break;
    }

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *rowData ;
    switch (pickerView.tag) {
        case 0:
            rowData = prioritylist[row] ;
            break;
        case 1:
            rowData = statelist[row] ; ;
            break;

}
    return rowData;
}


@end
