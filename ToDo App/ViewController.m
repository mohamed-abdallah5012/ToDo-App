//
//  ViewController.m
//  ToDo App
//
//  Created by Mohamed Abdallah on 4/2/21.
//

#import "ViewController.h"
#import "Task.h"
#import "TaskDetailsViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{

    NSMutableArray *males;
       NSMutableArray<Task*>* incomingDoneArray;

       NSData *aaa;


   }
   - (void)viewWillAppear:(BOOL)animated{
       
       incomingDoneArray=[NSMutableArray new];
       aaa =[NSData new];

       aaa=[[NSUserDefaults standardUserDefaults]objectForKey:@"DONE"];
       
       NSMutableArray *arr=[NSKeyedUnarchiver unarchiveObjectWithData:aaa];
       
        for (Task *ress in arr)
       {
           [incomingDoneArray addObject:ress];
           [_doneTabel reloadData];
          
       }
      
       
   }
   - (void)viewDidLoad {
       [super viewDidLoad];
       

       
       
       // Uncomment the following line to preserve selection between presentations.
       // self.clearsSelectionOnViewWillAppear = NO;
       
       // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       // self.navigationItem.rightBarButtonItem = self.editButtonItem;

   }

   #pragma mark - Table view data source

   - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   #warning Incomplete implementation, return the number of sections
       return 1;
   }

   - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   #warning Incomplete implementation, return the number of rows
       
       return [incomingDoneArray count];
   }


   - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
       
       // Configure the cell...
       //cell.textLabel.text=@"mohamed";
       cell.textLabel.text=[incomingDoneArray objectAtIndex:indexPath.row].name;
       if([[[incomingDoneArray objectAtIndex:indexPath.row] priority] isEqualToString:@"High"]){
           cell.imageView.image =[UIImage imageNamed:@"H.png"] ;
        }
        else if([[[incomingDoneArray objectAtIndex:indexPath.row] priority] isEqualToString:@"Mid"]){
            cell.imageView.image =[UIImage imageNamed:@"M.png"] ;
        }
        else  if([[[incomingDoneArray objectAtIndex:indexPath.row] priority] isEqualToString:@"Low"]){
            cell.imageView.image =[UIImage imageNamed:@"L.png"] ;
        }
           
       return cell;
   }


   - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
       return 50;
   }
   - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
   {
       TaskDetailsViewController *sec=[self.storyboard
                           instantiateViewControllerWithIdentifier:@"TaskDetailsViewController"];
       sec.data=[incomingDoneArray objectAtIndex:indexPath.row];

       [self.navigationController pushViewController:sec animated:YES];
   }

   // Override to support editing the table view.
   - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
       if (editingStyle == UITableViewCellEditingStyleDelete) {
           // Delete the row from the data source
           
           NSData  *a=[[NSUserDefaults standardUserDefaults]objectForKey:@"DONE"];
           incomingDoneArray=[NSKeyedUnarchiver unarchiveObjectWithData:a];
          
           for (Task *ress in incomingDoneArray)
          {
              if ([incomingDoneArray objectAtIndex:indexPath.row].name==ress.name) {
                  printf("%d",[incomingDoneArray objectAtIndex:indexPath.row].name);
                  printf("%d",ress.name);
                      [incomingDoneArray removeObject:ress];

              }

          }
           NSData *data=[NSKeyedArchiver archivedDataWithRootObject:incomingDoneArray requiringSecureCoding:NO error:nil];

           [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"DONE"];
           [[NSUserDefaults standardUserDefaults]synchronize];

           [_doneTabel reloadData];
           
           //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
       } else if (editingStyle == UITableViewCellEditingStyleInsert) {
           // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
       }
   }
   @end

