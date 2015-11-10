//
//  MailboxViewController.swift
//  Assignment 3
//
//  Created by Will Chan on 11/8/15.
//  Copyright © 2015 Will Chan. All rights reserved.
//

import UIKit

class MailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedView: UIImageView!
    @IBOutlet weak var messageView: UIImageView!
    @IBOutlet weak var messageBackgroundView: UIView!
    
    @IBOutlet weak var laterIcon: UIImageView!
    var messagePosition: CGPoint!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = feedView.image!.size
        messagePosition = messageView.frame.origin
        laterIcon.alpha = 0
        listIcon.alpha = 0
        deleteIcon.alpha = 0
        archiveIcon.alpha = 0
        rescheduleView.alpha = 0
        listView.alpha = 0
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "revealMenuGesture:")
        edgeGesture.edges = UIRectEdge.Left
        mainView.addGestureRecognizer(edgeGesture)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func panGestureRecognizer(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(messageView)
        
        if sender.state == UIGestureRecognizerState.Began {
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            messageView.frame.origin.x = translation.x
            
            
            laterIcon.alpha = convertValue(translation.x, r1Min: 0, r1Max: -60, r2Min: 0, r2Max: 1)
            print(laterIcon.frame.origin.x)
            
            archiveIcon.alpha = convertValue(translation.x, r1Min: 0, r1Max: 60, r2Min: 0, r2Max: 1)
            
            
            //Yellow if swiping to the left
            if translation.x < -60 && translation.x > -260 {
                
                laterIcon.frame.origin.x = messageView.frame.origin.x + messageView.frame.width + 20
                listIcon.frame.origin.x = messageView.frame.origin.x + messageView.frame.width + 20
                self.laterIcon.alpha = 1
                self.listIcon.alpha = 0
                self.archiveIcon.alpha = 0
                self.deleteIcon.alpha = 0
                
                
                UIView.animateWithDuration(0.15, animations: { () -> Void in
                    self.messageBackgroundView.backgroundColor = UIColor(red: 1, green: 0.875, blue: 0.08235, alpha: 1)
                    
                    }, completion: { (Bool) -> Void in
                      
                        
                })
                
            } else if translation.x <= -260 {
                
                laterIcon.frame.origin.x = messageView.frame.origin.x + messageView.frame.width + 20
                listIcon.frame.origin.x = messageView.frame.origin.x + messageView.frame.width + 20
                self.laterIcon.alpha = 0
                self.listIcon.alpha = 1
                self.archiveIcon.alpha = 0
                self.deleteIcon.alpha = 0
                
                UIView.animateWithDuration(0.15, animations: { () -> Void in
                    self.messageBackgroundView.backgroundColor = UIColor(red: 201/255, green: 108/255, blue: 15/255, alpha: 1)
                    
                    
                    }, completion: { (Bool) -> Void in
                        
                })
            }
            
            //Archive if swipe right
             else if translation.x > 60 && translation.x < 260 {
                archiveIcon.frame.origin.x = messageView.frame.origin.x - 40
                deleteIcon.frame.origin.x = messageView.frame.origin.x - 40
                self.laterIcon.alpha = 0
                self.listIcon.alpha = 0
                self.archiveIcon.alpha = 1
                self.deleteIcon.alpha = 0
                
                
                UIView.animateWithDuration(0.15, animations: { () -> Void in
                    self.messageBackgroundView.backgroundColor = UIColor(red: 6/255, green: 227/255, blue: 9/255, alpha: 1)
                    
                    }, completion: { (Bool) -> Void in
                        
                        
                })

            }
            
            else if translation.x >= 260 {
                archiveIcon.frame.origin.x = messageView.frame.origin.x - 40
                deleteIcon.frame.origin.x = messageView.frame.origin.x - 40
                self.laterIcon.alpha = 0
                self.listIcon.alpha = 0
                self.archiveIcon.alpha = 0
                self.deleteIcon.alpha = 1
                
                UIView.animateWithDuration(0.15, animations: { () -> Void in
                    self.messageBackgroundView.backgroundColor = UIColor(red: 201/255, green: 22/255, blue: 0/255, alpha: 1)
                    
                    
                    }, completion: { (Bool) -> Void in
                        
                })
            }
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            
            if translation.x < -60 && translation.x > -260 {
               
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.messageView.frame.origin.x = -self.messageView.frame.width
                    self.laterIcon.frame.origin.x = -30
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.messageView.backgroundColor = UIColor(red: 1, green: 0.875, blue: 0.08235, alpha: 1)
                        
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.rescheduleView.alpha = 1
                        })
                        
                        
                        
                        
                        
                })
            } else if translation.x <= -260 {
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.messageView.frame.origin.x = -self.messageView.frame.width
                    self.listIcon.frame.origin.x = -30
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.messageBackgroundView.backgroundColor = UIColor(red: 201/255, green: 108/255, blue: 15/255, alpha: 1)
                        
                        UIView.animateWithDuration(0.2, animations: { () -> Void in
                            self.listView.alpha = 1
                        })
                        
                        
                        
                })
                
                
                
            } else if translation.x > 60 && translation.x < 260 {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.messageView.frame.origin.x = self.messageView.frame.width
                    self.archiveIcon.frame.origin.x = self.messageView.frame.width + 10
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.messageBackgroundView.backgroundColor = UIColor(red: 6/255, green: 227/255, blue: 9/255, alpha: 1)
                        
                        UIView.animateWithDuration(0.25, animations: { () -> Void in
                            self.feedView.frame.origin.y -= self.messageView.frame.height
                        })
                        
                        
                        
                })
            } else if translation.x >= 260 {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.messageView.frame.origin.x = self.messageView.frame.width
                    self.deleteIcon.frame.origin.x = self.messageView.frame.width + 10
                    
                    }, completion: { (Bool) -> Void in
                        
                        self.messageBackgroundView.backgroundColor = UIColor(red: 201/255, green: 22/255, blue: 0/255, alpha: 1)
                        
                        UIView.animateWithDuration(0.25, animations: { () -> Void in
                            self.feedView.frame.origin.y -= self.messageView.frame.height
                        })
                        
                        
                        
                })
            }
            
            
            else {
                UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: { () -> Void in
                    
                    self.messageView.frame.origin = self.messagePosition
                    
                    }, completion: { (Bool) -> Void in
                        self.messageBackgroundView.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
                        
                })

            }
            
            
            
            
        }
        
        
    }
    
    @IBAction func rescheduleTapGesture(sender: AnyObject) {
        if sender.view == rescheduleView {
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.rescheduleView.alpha = 0
                self.messageView.frame.origin.x = -self.messageView.frame.width
                self.archiveIcon.frame.origin.x = -self.messageView.frame.width - 10
                
                }, completion: { (Bool) -> Void in
                    
                    
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        
                        
                        }, completion: { (Bool) -> Void in
                            
                            self.messageView.backgroundColor = UIColor(red: 1, green: 0.875, blue: 0.08235, alpha: 1)
                    
                            UIView.animateWithDuration(0.25, animations: { () -> Void in
                                self.feedView.frame.origin.y -= self.messageView.frame.height
                                
                                }, completion: { (Bool) -> Void in
                                    self.messageBackgroundView.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
                                    
                            })
                            
                    })
            })
            
            
            
        }
    }

    @IBAction func listTapGesture(sender: UITapGestureRecognizer) {
        if sender.view == listView {
            
           
            
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.listView.alpha = 0
                self.messageView.frame.origin.x = -self.messageView.frame.width
                self.listIcon.frame.origin.x = -self.messageView.frame.width - 10
                
                }, completion: { (Bool) -> Void in
                    
                    
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        
                        
                        }, completion: { (Bool) -> Void in
                            
                            self.messageBackgroundView.backgroundColor = UIColor(red: 201/255, green: 108/255, blue: 15/255, alpha: 1)
                            
                            UIView.animateWithDuration(0.25, animations: { () -> Void in
                                self.feedView.frame.origin.y -= self.messageView.frame.height
                                
                                }, completion: { (Bool) -> Void in
                                    self.messageBackgroundView.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
                                    
                            })
                            
                    })
            })
        }
    }
    
    
    @IBAction func mainMenuTapGesture(sender: UITapGestureRecognizer) {
        if sender.view == mainView {
            
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.95, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                
                self.mainView.frame.origin.x = 0
                
                }, completion: { (Bool) -> Void in
                    
                    
            })
            
        }
    }

    @IBAction func revealMenuGesture(sender: UIScreenEdgePanGestureRecognizer) {
        
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            mainView.frame.origin.x = translation.x
            
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            if velocity.x > 0 {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: velocity.x/20, options: [], animations: { () -> Void in
                    
                    self.mainView.frame.origin.x = self.view.frame.width - 30
                    
                    }, completion: { (Bool) -> Void in
                        
                        
                })
            } else {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0, options: [], animations: { () -> Void in
                    
                    self.mainView.frame.origin.x = 0
                    
                    }, completion: { (Bool) -> Void in
                        
                        
                })
            }
        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
