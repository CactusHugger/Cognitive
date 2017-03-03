require "Datavyu_API.rb"
begin
	sg2 = createNewColumn("strictgaze2", "strictgaze", "objtype", "ca", "pg", "gesturetype")

	child_sg = getVariable("childstrictgaze")
	pgest = getVariable("parentgesture")

	num_csg = 0
	num_pgest = 0 

	for cell in child_sg.cells
		ncell = sg2.make_new_cell
		ncell.change_arg('onset',cell.onset)
		ncell.change_arg('offset',cell.offset)
		num_csg = num_csg + 1
	end

	for cell in pgest.cells
		num_pgest = num_pgest + 1
	end

	for i in 0..(num_csg-1)
		for j in 0..(num_pgest - 1)
			if(sg2.cells[i].onset >= pgest.cells[j].onset && sg2.cells[i].onset <= (pgest.cells[j].offset + 1000))
				sg2.cells[i].change_code("ca",1)
				if(pgest.cells[j].gesturetypetwo == "na")
					sg2.cells[i].change_code("gesturetype",pgest.cells[j].gesturetype)
					if (sg2.cells[i].onset >= pgest.cells[j].offset)
						sg2.cells[i].change_code("pg",100)
					else
						sg2.cells[i].change_code("pg",sprintf('%.2f',(((sg2.cells[i].onset - pgest.cells[j].onset)*100.0)/((pgest.cells[j].offset - pgest.cells[j].onset)))))
						
					end
				else
					sg2.cells[i].change_code("gesturetype","c")
					
					if (sg2.cells[i].onset >= pgest.cells[j].offset)
						sg2.cells[i].change_code("pg",100)
					else
						sg2.cells[i].change_code("pg",sprintf('%.2f',(((sg2.cells[i].onset - pgest.cells[j].onset)*100.0)/((pgest.cells[j].offset - pgest.cells[j].onset)))))
						
					end
				end

				break
			else
				sg2.cells[i].change_code("ca",0)
				sg2.cells[i].change_code("pg","na")
				sg2.cells[i].change_code("gesturetype","na")
			end
		end
	end







	setColumn(sg2)
end
