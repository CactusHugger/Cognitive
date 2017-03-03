require 'Datavyu_API.rb'
begin
 	ja = createNewColumn(
 		"ja",
        "plabeling", # Name of the column
        "pgesture",      # code used for the object (bn, ea, pu, etc...)
        "plook",     # distance based on center of object, use ceiling view, can be as precise as allowed (e.g., 25.25)
        "cverbal",         # width of the image that was cropped
        "cgesture",         # height of the image that was cropped
        "directby",    # area of selection made in photoshop
        "pattend", # height of selection
        "cattend")  # width of selection

# l.onset <= sgaze.onset && l.offset >= (sgaze.onset - 2000)


	sgaze = getVariable('strictgaze')
	labeling = getVariable('labeling')
	parentgesture = getVariable('gestureColTPV')
	parentlook = getVariable('parentlook')
	childgesture = getVariable('childgesture')
	childverbal = getVariable('childverbal')

	nja = 0
	sgazecells = sgaze.cells
	for cell in sgazecells
		ncell = ja.make_new_cell
		ncell.change_arg('onset',cell.onset)
		ncell.change_arg('offset',cell.offset)
		nja = nja + 1
	end

	#ja.cells[1].change_code("plabeling",ja.cells[1].offset)



	#Start of parent labeling

	#number of labeling cells
	nlabel = 0
	for cell in labeling.cells
		nlabel = nlabel +1
	end

	for i in 0..(nja-1)
		for j in 0..(nlabel-1)
			if (labeling.cells[j].onset >= (sgaze.cells[i].onset-2000) && labeling.cells[j].onset <= sgaze.cells[i].onset)
				ja.cells[i].change_code("plabeling",1)
			elsif (labeling.cells[j].offset >= (sgaze.cells[i].onset-2000) && labeling.cells[j].offset <= sgaze.cells[i].onset)
				ja.cells[i].change_code("plabeling",1)
			elsif (labeling.cells[j].onset <= sgaze.cells[i].onset && labeling.cells[j].offset >= (sgaze.cells[i].onset-2000))
				ja.cells[i].change_code("plabeling",1)
			end
		end
	end
	for i in 0..(nja-1)
		if ja.cells[i].plabeling != "1"
			ja.cells[i].change_code("plabeling",0)
		end
	end
	#end of parent labeling

	#start of parenting gesturing
	#number of gesturing cells
	npgesture = 0
	for cell in parentgesture.cells
		npgesture = npgesture + 1
	end

	for i in 0..(nja-1)
		for j in 0..(npgesture-1)
			if (parentgesture.cells[j].onset >= (sgaze.cells[i].onset-2000) && parentgesture.cells[j].onset <= sgaze.cells[i].onset)
				ja.cells[i].change_code("pgesture",1)
			elsif (parentgesture.cells[j].offset >= (sgaze.cells[i].onset-2000) && parentgesture.cells[j].offset <= sgaze.cells[i].onset)
				ja.cells[i].change_code("pgesture",1)
			elsif (parentgesture.cells[j].onset <= sgaze.cells[i].onset && parentgesture.cells[j].offset >= (sgaze.cells[i].onset-2000))
				ja.cells[i].change_code("pgesture",1)
			end
		end
	end
	for i in 0..(nja-1)
		if ja.cells[i].pgesture != "1"
			ja.cells[i].change_code("pgesture",0)
		end
	end
	#end of parent gesturing

	#start of parent looking and pattend
	nplook = 0
	for cell in parentlook.cells
		nplook = nplook + 1
	end

	for i in 0..(nja-1)
		for j in 0..(nplook-1)
			if (parentlook.cells[j].onset >= (sgaze.cells[i].onset-2000) && parentlook.cells[j].onset <= sgaze.cells[i].onset)
				ja.cells[i].change_code("plook",1)
				#ja.cells[i].change_code("pattend",parentlook.cells[j].code01)
			elsif (parentlook.cells[j].offset >= (sgaze.cells[i].onset-2000) && parentlook.cells[j].offset <= sgaze.cells[i].onset)
				ja.cells[i].change_code("plook",1)
				#ja.cells[i].change_code("pattend",parentlook.cells[j].code01)
			elsif (parentlook.cells[j].onset <= sgaze.cells[i].onset && parentlook.cells[j].offset >= (sgaze.cells[i].onset-2000))
				ja.cells[i].change_code("plook",1)
			end
		end
	end
	for i in 0..(nja-1)
		if ja.cells[i].plook != "1"
			ja.cells[i].change_code("plook",0)
		end
	end
	#end of parent looking and pattend

	#start of child verbal
	ncverbal = 0
	for cell in childverbal.cells
		ncverbal = ncverbal + 1
	end

	for i in 0..(nja-1)
		for j in 0..(ncverbal-1)
			if (childverbal.cells[j].onset >= (sgaze.cells[i].onset-2000) && childverbal.cells[j].onset <= sgaze.cells[i].onset)
				ja.cells[i].change_code("cverbal",1)
			elsif (childverbal.cells[j].offset >= (sgaze.cells[i].onset-2000) && childverbal.cells[j].offset <= sgaze.cells[i].onset)
				ja.cells[i].change_code("cverbal",1)
			elsif (childverbal.cells[j].onset <= sgaze.cells[i].onset && childverbal.cells[j].offset >= (sgaze.cells[i].onset-2000))
				ja.cells[i].change_code("cverbal",1)
			end
		end
	end
	for i in 0..(nja-1)
		if ja.cells[i].cverbal != "1"
			ja.cells[i].change_code("cverbal",0)
		end
	end
	#end of child verbal

	#start of child gesturing
	ncgesture = 0
	for cell in childgesture.cells
		ncgesture = ncgesture + 1
	end

	for i in 0..(nja-1)
		for j in 0..(ncgesture-1)
			if (childgesture.cells[j].onset >= (sgaze.cells[i].onset-2000) && childgesture.cells[j].onset <= sgaze.cells[i].onset)
				ja.cells[i].change_code("cgesture",1)
			elsif (childgesture.cells[j].offset >= (sgaze.cells[i].onset-2000) && childgesture.cells[j].offset <= sgaze.cells[i].offset)
				ja.cells[i].change_code("cgesture",1)
			elsif (childgesture.cells[j].onset <= sgaze.cells[i].onset && childgesture.cells[j].offset >= (sgaze.cells[i].onset-2000))
				ja.cells[i].change_code("cgesture",1)
			end
		end
	end
	for i in 0..(nja-1)
		if ja.cells[i].cgesture != "1"
			ja.cells[i].change_code("cgesture",0)
		end
	end
	#end of child gesturing

	#start of child attend
	for i in 0..(nja-1)
		ja.cells[i].change_code("cattend",sgaze.cells[i].attend)
	end
	#end of child attend



	#Pseudo-test scripts ignore
	#ja.cells[1].change_code("plabeling",t)
	#sgaze.cells[1].change_code('attend',ja.cells[1].offset) ; works!

	setColumn(ja)
end