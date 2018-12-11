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
       View.onUpdate(dc);
        
        var team1Text = new Ui.Text({
            :text=> "Team 1",
            :color=>Graphics.COLOR_GREEN,
            :font=>Graphics.FONT_MEDIUM,
            :locX =>(dc.getWidth() / 2) - 30,
            :locY=>(dc.getHeight() / 6),
            :justification=>Gfx.TEXT_JUSTIFY_RIGHT
        });
        team1Text.draw(dc);
        
        var team2Text = new Ui.Text({
            :text=> "Team 2",
            :color=>Graphics.COLOR_BLUE,
            :font=>Graphics.FONT_MEDIUM,
            :locX =>(dc.getWidth() / 2) + 30,
            :locY=>(dc.getHeight() / 6),
            :justification=>Gfx.TEXT_JUSTIFY_LEFT
        });
        team2Text.draw(dc);
        
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(0, dc.getHeight() / 3, dc.getWidth(), dc.getHeight() / 3); 
        
        drawScore(dc);
        
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.drawLine(0, (dc.getHeight() / 3) * 2, dc.getWidth(), (dc.getHeight() / 3) * 2);
        
        var time = new Ui.Text({
            :text=> currentTime,
            :color=>Graphics.COLOR_LT_GRAY,
            :font=>Graphics.FONT_LARGE,
            :locX => (dc.getWidth() / 2),
            :locY=>(dc.getHeight() / 4) * 3,
            :justification=>Gfx.TEXT_JUSTIFY_CENTER
        });
        time.draw(dc);
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
    
    function drawScore(dc) {
    	var team1ScoreText = new Ui.Text({
            :text=> team1Score.toString(),
            :color=>Graphics.COLOR_GREEN,
            :font=>Graphics.FONT_LARGE,
            :locX => (dc.getWidth() / 2) - 30,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER,
            :justification=>Gfx.TEXT_JUSTIFY_RIGHT
        });
        team1ScoreText.draw(dc);
        
        var separator = new Ui.Text({
            :text=> ":",
            :color=>Graphics.COLOR_LT_GRAY,
            :font=>Graphics.FONT_LARGE,
            :locX => (dc.getWidth() / 2),
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER,
            :justification=>Gfx.TEXT_JUSTIFY_CENTER
        });
        separator.draw(dc);
        
        var team2ScoreText = new Ui.Text({
            :text=> team2Score.toString(),
            :color=>Graphics.COLOR_BLUE,
            :font=>Graphics.FONT_LARGE,
            :locX => (dc.getWidth() / 2) + 30,
            :locY=>WatchUi.LAYOUT_VALIGN_CENTER,
            :justification=>Gfx.TEXT_JUSTIFY_LEFT
        });
        team2ScoreText.draw(dc);
    }
	
	function getCurrentScore() {
    	System.println("Current Score: Team 1 - " + team1Score + " - Team 2 - " + team2Score);
    }
}
