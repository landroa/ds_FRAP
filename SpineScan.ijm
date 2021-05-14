open("")
output = File.directory;
run("Rotate 90 Degrees Left");
run("Enhance Contrast", "saturated=0.35");
run("Mean...", "radius=2");
getDimensions(width,height,channels,slices,frames);
makeRectangle(0, 22, width, height/20);
n = 10; // Number of parses <--- You can change this for finer parses.
for (i = height/n;i<height;i = i+height/n){
	makeLine(0,i,width,i);
	roiManager("add");
	//run("Plot Profile");
}
filename = getTitle();
trunc = substring(filename,0,lengthOf(filename)-4); // Gets rid of the .tif extension
roiManager("multi plot")
name = trunc +".csv";
Plot.showValues();
saveAs("Results",output + name);
print("File has been saved to ", output);
waitForUser("LineScan Complete" );
roiManager("delete");
run("Close All"); // Primes the macro for the next file