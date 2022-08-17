#!/bin/bash

artist_name=""
song_name=""

# Gets random song and its respective artist from the list of songs
GetRandomArtistAndSong() {
  numSongs=$(cat data/lyrics.json | jq 'length')
  randomNum=$((RANDOM % $numSongs))
  song=$(jq -r --argjson num "$randomNum" '.[$num]' < data/lyrics.json)
  artist_name=$(jq -r '.artist' <<< "$song")
  song_name=$(jq -r '.song' <<< "$song")
}

echo "Welcome to the Song Guesser!"
echo "Ready to play? (y/n)"
read -r play

while [ "$play" == "y" ]  # Loop until the user answers "y"
do
  echo "Fetching lyrics..."
  echo
  sleep 3

  GetRandomArtistAndSong  # Calls the function to get a random song and its respective artist
  # Call the lyrics API to get the lyrics of the song
  lyrics=$(./lyrics.sh -a "$artist_name" -s "$song_name")
  echo "$lyrics"
  echo

  echo "Guess the name of the song or its artist"
  read -r guess
  guess=$(echo "$guess" | tr '[:upper:]' '[:lower:]' | xargs)  # Lowercase the guess, trim whitespaces

  # Checks if the user's guess matches the artist or song name
  if [[ "$guess" == "$song_name" || "$guess" == "$artist_name" ]]
  then
    echo "You got it!"
  else
    echo "Incorrect!"
  fi

  # Show the user the answer, and ask if they want to play again
  echo "The song was $song_name by $artist_name"
  echo "Ready to play again? (y/n)"
  read -r play
done
