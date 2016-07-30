

import processing.opengl.*;
import SimpleOpenNI.*;
SimpleOpenNI kinect;

void setup()
{
    size(1024, 768, OPENGL);
    kinect = new SimpleOpenNI(this);
  // enable depthMap generation 
  if(kinect.enableDepth() == false)
  {
     println("Can't open the depthMap, maybe the camera is not connected!"); 
     exit();
     return;
  }
}

void draw()
{
    background(0);
    kinect.update();
    // prepare to draw centered in x-y
    // pull it 1000 pixels closer on z
    translate(width/2, height/2, 1000);
    rotateX(radians(180)); // flip y-axis from "realWorld" 2
    stroke(255,0,0);
    // get the depth data as 3D points
    PVector[] depthPoints = kinect.depthMapRealWorld();

    for(int i = 0; i < depthPoints.length; i++)
    {
        // get the current point from the point array
        PVector currentPoint = depthPoints[i];
        // draw the current point
        point(currentPoint.x, currentPoint.y, currentPoint.z);
    }
}

void mousePressed(){
save("facundo3d.png");
}

