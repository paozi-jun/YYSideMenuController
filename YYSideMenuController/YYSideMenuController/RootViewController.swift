
import UIKit

class RootViewController: UIViewController {

    var menuVC:YYSideMenuController?
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        
        var leftBt = UIButton(frame:CGRectMake(0,100,160,50))
        leftBt.setTitle("show left", forState: UIControlState.Normal)
        leftBt.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        leftBt.addTarget(self, action: "showLeft", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(leftBt)
        
        var rightBt = UIButton(frame:CGRectMake(160,100,160,50))
        rightBt.setTitle("show right", forState: UIControlState.Normal)
        rightBt.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
        rightBt.addTarget(self, action: "showRight", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(rightBt)
        
        var nextBt = UIButton(frame:CGRectMake(0, 300, 320, 50))
        nextBt.setTitle("nextViewController", forState: UIControlState.Normal)
        nextBt.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        nextBt.addTarget(self, action: "nextBtClick", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(nextBt)
    }

    func showRight(){
        if self.menuVC{
            self.menuVC!.showRightViewController(true)
        }
    }
    
    func showLeft(){
        if self.menuVC{
            self.menuVC!.showLeftViewController(true)
        }
    }
    
    func nextBtClick(){
        var vc = SideViewController(nibName: nil, bundle: nil)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
