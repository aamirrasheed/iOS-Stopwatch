//
//  ViewController.swift
//  Stopwatch
//
//  Created by Aamir Rasheed on 12/15/14.
//  Copyright (c) 2014 udemy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // instance variable for timer
    var timer = NSTimer();
    
    // milliseconds variable to keep track of time elapsed
    var milliseconds = 0;
    
    // used to keep track of whether time has elapsed when the stopTimer is called
    var timerStopped = true;
    
    // reference for the displayed numbers
    @IBOutlet var timerLabel: UILabel!
    
    //reference for stop button label to change
    @IBOutlet var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad();

    }
    
    @IBAction func startTimer(sender: AnyObject) {
        
        // if condition to prevent anything happening if user presses this button while timer is running
        if(milliseconds == 0 || timerStopped){
            
            //yes, a new timer object is created every time the timer is stopped -___-
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true);
        
            // no matter the state of the timer, you will always need to have stopButton title be Stop when button is pressed
            stopButton.setTitle("Stop", forState: .Normal);
            timerStopped = false;
        }
        
    }
    
    // called every millisecond when timer is active
    func updateTimer(){
        
        /* "displayed" numbers are the numbers that actually get displayed on the label */
        var displayedMilliseconds = milliseconds % 100;
        
        var seconds = milliseconds/100;
        var displayedSeconds = seconds % 60;
        
        var minutes = seconds/60;
        var displayedMinutes = minutes % 60;
        
        
        /* separate variable for string because of special case of single digit numbers */
        var displayedMillisecondsString:String;
        var displayedSecondsString:String;
        var displayedMinutesString:String;
        
        /* logic for displaying a 0 in front of single digit numbers */
        //milliseconds
        if(displayedMilliseconds < 10){
            displayedMillisecondsString = "0\(displayedMilliseconds)"
        }
        else{
            displayedMillisecondsString = String(displayedMilliseconds);
        }
        // for seconds
        if(displayedSeconds < 10){
            displayedSecondsString = "0\(displayedSeconds)"
        }
        else{
            displayedSecondsString = String(displayedSeconds);
        }
        // for minutes
        if(displayedMinutes < 10){
            displayedMinutesString = "0\(displayedMinutes)"
        }
        else{
            displayedMinutesString = String(displayedMinutes);
        }
        
        timerLabel.text = "\(displayedMinutesString):\(displayedSecondsString):\(displayedMillisecondsString)";
        
        milliseconds++;
    }

    // serves as both stop and reset button
    @IBAction func stopTimer(sender: AnyObject) {
        
        // neither stop or reset function needs to be fired if no time has elapsed on timer
        if(milliseconds != 0){
            
            // "stop" function
            if(stopButton.currentTitle == "Stop"){
                stopButton.setTitle("Reset", forState: .Normal);
                timer.invalidate(); // this stops timer and sets timer's reference to nil
                timerStopped = true;
            }
                
            // "reset" function. Sets label to starting state and sets time elapsed to zero
            else if(stopButton.currentTitle == "Reset"){
                milliseconds = 0;
                timerLabel.text = "00:00:00";
                stopButton.setTitle("Stop", forState: .Normal);
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }


}

