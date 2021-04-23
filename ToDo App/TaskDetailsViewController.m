//
//  TaskDetailsViewController.m
//  ToDo App
//
//  Created by Mohamed Abdallah on 4/5/21.
//

#import "TaskDetailsViewController.h"
#import "EditTaskViewController.h"

@interface TaskDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *creationDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *reminderDate;
@property (weak, nonatomic) IBOutlet UITextView *desc;
@property (weak, nonatomic) IBOutlet UITextField *state;
@property (weak, nonatomic) IBOutlet UITextField *priority;
@property (weak, nonatomic) IBOutlet UITextField *name;

@end

@implementation TaskDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    _name.text=_data.name;
    _desc.text=_data.desc;
    _priority.text=_data.priority;
    
    _creationDate.date=_data.creationDate;
    _reminderDate.date=_data.reminderDate;
    _state.text=_data.state;
    
    

}
- (IBAction)toUpdateScreen:(id)sender {
    EditTaskViewController *sec=[self.storyboard
                        instantiateViewControllerWithIdentifier:@"EditTaskViewController"];
    sec.edited=_data;

    [self.navigationController pushViewController:sec animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
