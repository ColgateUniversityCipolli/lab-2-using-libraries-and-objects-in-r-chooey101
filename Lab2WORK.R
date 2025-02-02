library(stringr)
mus.vec<-list.dirs("MUSIC/") #Lists all files within the MUSIC folder
num.slash<-str_count(mus.vec, "/") #Vector which counts the number of slashes present within each file's name
album.sub<-mus.vec[num.slash == 2] #Vector holding names of all album subdirectories
for(i in 1:length(album.sub)){ #Loop which iterates through all albums of the album sub
pres.alb<-album.sub[i]
pres.files<-list.files(pres.alb)
wav.files <- pres.files[str_count(pres.files, ".wav")==1]
code.to.process <- c()
for(j in 1:length(wav.files)){
song.curr<-wav.files[j] #Obj referring to each song listed through the loop
artist.name<-(str_split(pres.alb, "/", simplify=TRUE)[2])
album.name<-(str_split(pres.alb, "/", simplify = TRUE)[3])
track.name<-(str_split(song.curr, "-", simplify=TRUE)[3])
alttrack.name<-(str_sub(track.name, end=-5L))
output.file<-paste(artist.name, "-", album.name, "-", alttrack.name, ".json", sep="")
output.command<-paste('streaming_extractor_music.exe "', song.curr, '" "', output.file, '"', sep = "")
code.to.process <- c(code.to.process, output.command)
}
}
writeLines(code.to.process, "batfile.txt")