library(stringr)
mus.vec<-list.dirs("MUSIC/") #Lists all files within the MUSIC folder
num.slash<-str_count(mus.vec, "/") #Vector which counts the number of slashes present within each file's name
album.sub<-mus.vec[num.slash == 2] #Vector holding names of all album subdirectories
code.to.process <- c() #Empty vector to store names of all songs
for(i in 1:length(album.sub)){ #Loop which iterates through all albums of each artist
pres.alb<-album.sub[i]
pres.files<-list.files(pres.alb)
wav.files <- pres.files[str_count(pres.files, ".wav")==1]
for(j in 1:length(wav.files)){ #Loop which iterates through each song for all albums
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
##########PART 2############
json_file <- "The Front Bottoms-Talon Of The Hawk-Au Revoir (Adios).json" #Obj containing name of json file
file_parts <- str_split(json_file, "-", simplify = TRUE)
artist <- file_parts[1]
album <- file_parts[2]
song <- str_replace(file_parts[3], ".json$", "")  
json_data <- fromJSON(json_file)
average_loudness <- json_data$lowlevel$average_loudness
spectral_energy_mean <- json_data$lowlevel$spectral_energy$mean
danceability <- json_data$rhythm$danceability
bpm <- json_data$rhythm$bpm
musical_key <- json_data$tonal$key_key
musical_mode <- json_data$tonal$key_scale
song_length <- json_data$metadata$audio_properties$length
print(paste("Artist:", artist)) 
print(paste("Album:", album))
print(paste("Song:", song))
print(paste("Average Loudness:", average_loudness))
print(paste("Mean Spectral Energy:", spectral_energy_mean))
print(paste("Danceability:", danceability))
print(paste("BPM:", bpm))
print(paste("Musical Key:", musical_key))
print(paste("Musical Mode:", musical_mode))
print(paste("Track Length (seconds):", song_length))