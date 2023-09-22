f=open("host.txt","r")
while(True):
    data=f.readline()
    if(data):
       if(data.__contains__("host_")):
        print("Listings2",data.strip(),"TO",data.replace("host_","").strip(),";")
    else:
        break
