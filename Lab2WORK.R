mus.vec<-list.dirs("MUSIC/") #Lists all files within the MUSIC folder
num.slash<-str_count(mus.vec, "/") #Vector which counts the number of slashes present within each file's name
album.sub<-mus.vec[num.slash == 2] #Vector holding characters of all album subdirectories
print(album.sub)
pres.alb<-album.sub[1]
pres.files<-list.files(pres.alb)
wav.files <- pres.files[str_count(pres.files, ".wav")==1]
song.1<-wav.files[1]
#code.to.process<-
track.files<-paste(pres.alb , pres.files , sep="/")
artist.name<-(str_split(pres.alb, "/", simplify=TRUE)[2])
album.name<-(str_split(pres.alb, "/", simplify = TRUE)[3])
track.name<-(str_split(song.1, "-", simplify=TRUE)[3])
alttrack.name<-(str_sub(track.name, end=-5L))

output.file<-paste(artist.name, "-", album.name, "-", alttrack.name, ".json", sep="")
output.file
