delete objects
try(closeRolloutFloater MainFloater) catch()

Rollout Menu01 "Parameters"
(
	spinner xPosSpinner "X Position:" range:[0, 1000, 0] type:#integer
	spinner yPosSpinner "Y Position:" range:[0, 1000, 0] type:#integer
	spinner zPosSpinner "Z Position:" range:[0, 1000, 0] type:#integer
	spinner directionSpinner "Direction:" range:[0, 360, 0] type:#integer
	spinner numSegmentSpinner "Number of Segments:" range:[10, 100, 10] type:#integer
	
	button makefence "Build a picket fence." width:100 height:30
	on makefence pressed do
	(
		local xpos = xPosSpinner.value
		local ypos = yPosSpinner.value
		local zpos = zPosSpinner.value
		local direction = directionSpinner.value
		local NOsegments = numSegmentSpinner.value
		local selectedColor = [204,153,255]
        -- Open the color picker dialog and store the selected color
        local dialog = colorPickerDlg selectedColor ""
        if dialog != undefined then
        (
            selectedColor = dialog
		)

		/*buildFence xpos ypos zpos direction NOsegments Fcolor*/
		buildFence xpos:xpos ypos:ypos zpos:zpos direction:direction NOsegments:NOsegments Fcolor:selectedColor

	)
)

MainFloater = newRolloutFloater "Lab 7 - Khanh" 250 170
addRollout Menu01 MainFloater

fn buildFence xpos:0 ypos:0 zpos:0 direction:0 NOsegments:10 Fcolor:[204,153,255] =
(
	delete objects
	FenceColor = Fcolor
	startpoint = undefined

	for i = 0 to NOsegments-1 do
	(
		/* initialize main parts */
		leftColumn = box length:4 width:4 height:40
		rightColumn = box length:4 width:4 height:40
		topline = box length:1 width:56 height:3
		bottomline = box length:1 width:56 height:3
		
		leftColumn.material = Standardmaterial diffuse:FenceColor
		rightColumn.material = Standardmaterial diffuse:FenceColor
		topline.material = Standardmaterial diffuse:FenceColor
		bottomline.material = Standardmaterial diffuse:FenceColor
		if startpoint != undefined then
		(
			leftColumn.parent = startpoint
			in coordsys parent leftColumn.pos = [65,0,0]
			rotate leftColumn (angleaxis direction [0, 0, 1])
		)
		else 
		(
			move leftColumn [xpos,ypos,zpos]
			rotate leftColumn (angleaxis direction [0, 0, 1])
		)
		rightColumn.parent = leftColumn
		topline.parent = leftColumn
		bottomline.parent = leftColumn
		in coordsys parent rightColumn.pos = [60,0,0]
		in coordsys parent topline.pos = [30,0,25]
		in coordsys parent bottomline.pos = [30,0,5]
			
		in coordsys parent rotate rightColumn (angleaxis direction [0, 0, 1])
		in coordsys parent rotate topline (angleaxis direction [0, 0, 1])
		in coordsys parent rotate bottomline (angleaxis direction [0, 0, 1])
		
		startPlank = undefined
		for j = 0 to 8 do
		(
			plank = box length:1 width:4 height:33
			plank.material = Standardmaterial diffuse:FenceColor
			if startPlank != undefined then
			(
				plank.parent = startPlank
				in coordsys parent plank.pos = [6,0,0]
			)
			else 
			(
				plank.parent = leftColumn
				in coordsys parent plank.pos = [6,-1,2]
			)
			
			in coordsys parent rotate plank (angleaxis direction [0, 0, 1])
			
			startPlank = plank
		)
		
		/* next loop stating point */
		startpoint = leftColumn
	)
)