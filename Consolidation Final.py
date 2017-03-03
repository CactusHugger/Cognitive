#Import libraries
import os
import sys
from tkinter import *
import codecs

#Frame check
frametotal = input("How many total frames: ")
frame = []
for i in range(0,int(frametotal)):
    if(len(str(i)) == 1):
        frame.append(str('000') + str(i))
    elif(len(str(i)) == 2):
        frame.append(str('00') + str(i))
    elif(len(str(i)) == 3):
        frame.append(str('0') + str(i))
    elif(len(str(i)) == 4):
        frame.append(str(i))

#Create GUI
root = Tk()
root.update()
root.file = filedialog.askdirectory()

#Get file directory
os.chdir(root.file)

#Create Dictionary
total = {}

#Counter number of files
count = 0
for f in os.listdir():
    count = count + 1

for i in range(count-1):    
    total['excel'+str(i)] = []
    #print('excel' + str(i))
    
#Create a multi-dimensional array and add csv data to array
fileloc = []

numfiles = len(os.listdir()) - 1
for f in os.listdir():
    a = ((root.file)+str("/")+(f))
    if not f.startswith('.'):
        fileloc.append(a)

           
for i in range(numfiles):
    a = fileloc[i]
    fileopen = open(a,"r",errors = 'ignore')
    for line in fileopen:
        total['excel'+str(i)].append(line.split(","))
        

rows = 0

#Searches for data and adds them into an individual array
area = []
for i in range(numfiles):
    for j in range(len(total['excel' + str(i)][0])):
        if(total['excel' + str(i)][0][j] == 'Area'):
            for k in range (1,len(total['excel' + str(i)])):
                area.append(total['excel' + str(i)][k][j])
        elif(total['excel' + str(i)][0][j] == 'Area\n'):
            for k in range (1,len(total['excel' + str(i)])):
                area.append(total['excel' + str(i)][k][j].rstrip("\n"))
width = []               
for i in range(numfiles):
    for j in range(len(total['excel' + str(i)][0])):
        if(total['excel' + str(i)][0][j] == 'Width'):
            for k in range (1,len(total['excel' + str(i)])):
                width.append(total['excel' + str(i)][k][j])
        elif(total['excel' + str(i)][0][j] == 'Width\n'):
            for k in range (1,len(total['excel' + str(i)])):
                width.append(total['excel' + str(i)][k][j].rstrip("\n"))

height = []
for i in range(numfiles):
    for j in range(len(total['excel' + str(i)][0])):
        if(total['excel' + str(i)][0][j] == 'Height'):
            for k in range (1,len(total['excel' + str(i)])):
                height.append(total['excel' + str(i)][k][j])
        elif(total['excel' + str(i)][0][j] == 'Height\n'):
            for k in range (1,len(total['excel' + str(i)])):
                height.append(total['excel' + str(i)][k][j].rstrip("\n"))
document = []
for i in range(numfiles):
    for j in range(len(total['excel' + str(i)][0])):
        if(total['excel' + str(i)][0][j] == 'Document'):
            for k in range (1,len(total['excel' + str(i)])):
                document.append(total['excel' + str(i)][k][j])
        elif(total['excel' + str(i)][0][j] == 'Document\n'):
            for k in range (1,len(total['excel' + str(i)])):
                document.append(total['excel' + str(i)][k][j].rstrip("\n"))
num = []
for i in range(numfiles):
    for j in range(len(total['excel' + str(i)][0])):
        if(total['excel' + str(i)][0][j] == 'Document'):
            for k in range (1,len(total['excel' + str(i)])):
                num.append(total['excel' + str(i)][k][j][-8:-4])

#Pseudoscript -----
#print(len(total['excel' + str(0)]))


#Merges data from multiple arrays into one array
data = []
data.append(area)
data.append(width)
data.append(height)
data.append(document)
data.append(num)



part = len(area)

#Checks for duplicates
dup = [-5]
print("Duplicates:")
print("-----------")

cd = 0
for i in range(len(num)):
    for j in range(len(dup)):
        if (num[i] == dup[j]):
            if(cd != 5):
                print(num[i], end = " ")
                cd = cd + 1
            else:
                print(num[i])
                cd = 0
    dup.append(num[i])

#Checks for missing frames
print(" ")
print("Missing Frames:")
print("--------------")
cf = 0
cf2 = 0
for i in range(len(frame)):
    if (frame[i] not in num):
        if(cf != 10):
            print(frame[i], end=" ")
            cf = cf + 1
        else:
            print(frame[i])
            cf = 0
    else:
        if(cf != 10):
            print("----", end=" ")
            cf = cf + 1
        else:
            print("----")
            cf = 0


#Create the output file

name = document[2][:-8]

output = open((str(name))+str(".csv"),"w")

output.write("Area")
output.write(",")
output.write("Width")
output.write(",")
output.write("Height")
output.write(",")
output.write("Document")
output.write(",")
output.write("Number")
output.write(",")
output.write("Onset")
output.write(",")
output.write("Offset")
output.write("\n")


for i in range(0,part):
    for j in range(0,5):
        output.write(data[j][i])
        output.write(",")

    output.write(str(int(int(data[4][i])*(1000/30))))
    output.write(",")
    output.write(str(int((int(data[4][i])+1)*(1000/30))))
    output.write("\n")
output.close()


              
