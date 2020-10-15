# What's the score?
"What's the score?" is a simple Garmin Connect-IQ app designed for the Forerunner 230 (should work with other devices but only tested against the Forerunner 230).

## Functionality
Tracks the score of a two team game. Primarily developed for Football, pressing the up key will increase the score by 1 for Team 1 while pressing the down key will increase the score by 1 for Team 2. Pressing the "Enter" button will undo the last score.

## Demo
![What's the score](https://github.com/KieranDotCo/whats-the-score/blob/master/assets/whats-the-score.png?raw=true)

## Links
https://developer.garmin.com/connect-iq/programmers-guide/getting-started/
https://github.com/dennybiasiolli/garmin-connect-iq

## Compile and Build
Create PRG file
`monkeyc -o dist/WHATS-THE-SCORE.PRG -f monkey.jungle -y developer_key`

Create IQ file
`monkeyc -e -o whats-the-score.iq -f monkey.jungle -y developer_key`