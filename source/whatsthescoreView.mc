using Toybox.WatchUi as Ui;
using Toybox.System;
using Toybox.Graphics as Gfx;

class whatsthescoreView extends Ui.View {

	var team1Score = 0;
	var team2Score = 0;
	var lastScored = new [0];
	var myTimer = new Timer.Timer();
	var currentTime;
	
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
        
        setScore();
        
        setCurrentTime();
        
        myTimer.start(method(:makeTimeAppear), 1000, true);
    }
    
    function setCurrentTime() {
    	var myTime = System.getClockTime(); // ClockTime object
		currentTime = myTime.hour.format("%02d") + ":" + myTime.min.format("%02d") + ":" + myTime.sec.format("%02d");
    }
    
    function makeTimeAppear() {
    	setCurrentTime();

    	Ui.requestUpdate();
		return true;
    }

    // Update the view
    function onUpdate(dc) {
    	setScore();
        View.findDrawableById("time").setText(currentTime);
       
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }
    
    function team1Scored() {
    	team1Score++;
    	lastScored.add(1);

		getCurrentScore();
		
		Ui.requestUpdate();
		return true;
    }
    
    function team2Scored() {
    	team2Score++;
    	lastScored.add(2);
    	
    	getCurrentScore();
    	
    	Ui.requestUpdate();
		return true;
    }
    
    function undo() {
    	if (lastScored.size() == 0) {
    		return true;
    	}
    	
    	var lastScoredTeam = lastScored[lastScored.size() - 1];
    	
    	if (lastScoredTeam == 1) {
    		team1Score--;
    	} else if (lastScoredTeam == 2) {
    		team2Score--;
    	}
    	
    	lastScored = lastScored.slice(0, lastScored.size() - 1);
    	
    	getCurrentScore();
    	
    	Ui.requestUpdate();
		return true;
    }

	function setScore() {
		View.findDrawableById("team1_score").setText(team1Score.toString());
        View.findDrawableById("team2_score").setText(team2Score.toString());
	}
	
	function getCurrentScore() {
    	System.println("Current Score: Team 1 - " + team1Score + " - Team 2 - " + team2Score);
    }
}
