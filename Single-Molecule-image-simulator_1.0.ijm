// Single Molecule image simulation for evaluation of detection
// Written by Patrice Mascalchi

// parameters -------
imsize = 256;
nbsm = 10;	// nb of single molecules

minamp = 2000;	// signal amplitude for single molecule 
maxamp = 20000;
sd = 1.3;	// gaussian sd
background = 4000;	// image background
sdnoise = 400;
// ------------------

newImage("Untitled", "16-bit black", imsize, imsize, 1);

centrey = newArray(0) ;											
centrex = newArray(0) ;											
singleamp = newArray(0);
print("\\Clear");
print("Particle,x,y,amplitude");

// generate random positions and signal amplitude
for (sm = 0; sm < nbsm; sm++) {
	v1 = randomizer(0, imsize);
	centreX = Array.concat(centreX, v1);
	v2 = randomizer(0, imsize);
	centreY = Array.concat(centreY, v2);
	v3 = parseInt(randomizer(minamp, maxamp));
	singleamp = Array.concat(singleamp, v3);

	// output table (comma separated)
	print(sm+1 +","+ v1 +","+ v2 +","+ v3);
}

for (i = 0; i < imsize; i++) {
   for (j = 0; j < imsize; j++) {
        amplitude = background;
	for (k = 0; k < nbsm; k++) {
		position = pow(i - centreX[k], 2) + pow(j - centreY[k], 2);
		amplitude = amplitude + singleamp[k] * exp(-position / (2 * sd * sd) );
	}

        setPixel (i, j, amplitude);
        //print(i , j);

   }
}

run("Add Specified Noise...", "standard="+sdnoise);

updateDisplay() 

// functions
function randomizer(min, max){
	rval = random;
	return rval * (max - min) + min;
}
