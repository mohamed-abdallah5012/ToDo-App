//
//  ViewController.h
//  ToDo App
//
//  Created by Mohamed Abdallah on 4/2/21.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
 <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *doneTabel;


@end

