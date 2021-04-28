// This macro allows the user to plot 2 results parameters found in the results table. 
// 16 May 2016, Kees Straatman, University of Leicester 

// 28 April 2021 added option to change the marker style and handle the Label entry in a results table

macro Results_graph{

	types = newArray("line", "connected circle", "filled", "bar", "separated bar", "circle", "box", "triangle", "diamond", "cross", "x", "dot");
	L = false;
	
	// Collect parameters from results table
	headings = split(String.getResultsHeadings);
	H = headings[0]; H1 = headings[1];
	for (i=1; i<lengthOf(headings); i++){
		H = Array.concat(H,headings[i]);
 	} 

 	// Check if Label is displayed in the results table and delete from selection option if present
	if (H[0] == "Label"){
		L = true;
		H = Array.delete(H, "Label");
	} 

 	//Dialogue box
	Dialog.create("Menu");
		Dialog.addChoice("Select the results you want to analyse", H);
		if (L==true){
			Dialog.addChoice("Select the results you want to analyse", H, H[2]);
		}else{
			Dialog.addChoice("Select the results you want to analyse", H, H[1]);
		}
		Dialog.addChoice("Marker style:", types, "circle");
 	Dialog.show();

 	// Collect answers
	choice1=Dialog.getChoice;
	choice2=Dialog.getChoice;
	types = Dialog.getChoice();
 
	// Collect data points from results table
	R=nResults();
	xValues=newArray(R);
	yValues=newArray(R);
	for(i=0;i<R;i++){
		yValues[i]=getResult(choice1,i);
		xValues[i]=getResult(choice2,i);
	}
 
	// Create plot
	Plot.create(choice1+"-"+choice2, choice1, choice2);
	Plot.add(types,xValues, yValues);
	Plot.show()

} 