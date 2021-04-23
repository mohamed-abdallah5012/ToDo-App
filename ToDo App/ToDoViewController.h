//
//  ToDoViewController.h
//  ToDo App
//
//  Created by Mohamed Abdallah on 4/5/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoViewController : UIViewController
<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *toDoTabel;

@end

NS_ASSUME_NONNULL_END
