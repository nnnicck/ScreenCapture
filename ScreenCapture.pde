/*
ScreenCapture by Nick Baker and The Imaging Center at Smith College

Capture the screen and save as PNG images in a uniquely named subfolder

Creative Commons License - Attribution-NonCommercial-ShareAlike - CC BY-NC-SA
*/

import java.awt.*;
PImage screenshot;

int imgCount;
String folder;
 
void setup() {
  // set the size of the Processing window and initiate our image counter
  size(1280, 720);
  imgCount = 1;
  
  // give the folder of screenshots a unique name to avoid overwriting previous runs
  folder = "screens-" + String.valueOf(System.currentTimeMillis());
}
 
void draw() {
  
  // try to grab a screenshot image
  try {
    screenshot = new PImage(new Robot().createScreenCapture(new Rectangle(0, 0, displayWidth, displayHeight)));
  } catch (AWTException e) { }
  
  // if we got the screenshot successfully...
  if (screenshot != null) {
    
    // display the captured screenshot in the Processing window
    image(screenshot, 0, 0, width, height);
    
    // save the screenshot (with leading zeros to help ffmpeg sort correctly)
    screenshot.save(savePath(folder + "/" + 
      (imgCount < 10000000 ? "0" : "") + 
      (imgCount < 1000000 ? "0" : "") + 
      (imgCount < 100000 ? "0" : "") + 
      (imgCount < 10000 ? "0" : "") + 
      (imgCount < 1000 ? "0" : "") + 
      (imgCount < 100 ? "0" : "") + 
      (imgCount < 10 ? "0" : "") + 
      imgCount + ".png"));
    imgCount++;
  }
  
  // wait one second (1000ms) before taking the next screenshot
  delay(1000);
}
 
// bonus code:
// when you're done, use the ffmpeg command line tool to assemble the screenshots into a movie:
// ffmpeg -r 15 -i SCREENSHOTS-FOLDER/%*.png -q:v 0 -vb 20M -vcodec mpeg4 -r 15 SCREENSHOTS.mp4
