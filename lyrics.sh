#!/bin/bash

# Okay, you've found us out. It's not a real API.
# Author: Alexander Epstein https://github.com/alexanderepstein
# Codecademy Edits by Prabhjot Singh https://github.com/Prince25
currentVersion="1.23.0"
artist="false"
song="false"
filePath=""
dataFile="data/lyrics.json"

getConfiguredPython()
{
  if command -v python3 &>/dev/null; then
    configuredPython="python3"
  elif  command -v python2 &>/dev/null; then
    configuredPython="python2"
  elif command -v python &>/dev/null; then
    configuredPython="python"
  else
    echo "Error: This tool requires python to be installed."
    return 1
  fi
}


if [[ $(uname) != "Darwin" ]]; then
  python()
  {
    case "$configuredPython" in
      python3) python3 "$@" ;;
      python2) python2 "$@" ;;
      python)  python "$@" ;;
    esac
  }
fi


## Finds lyrics from the JSON file based on the artist and song, and then echoes it to stdout
FindLyrics() {
  artist="$1"
  song="$2"

  jq -c '.[]' "$dataFile" | while read -r item; do
    if [[ "$(jq -r '.artist' <<< "$item")" == "$artist" ]] && [[ "$(jq -r '.song' <<< "$item")" == "$song" ]]; then
      printf "$(jq -r '.lyrics' <<< "$item")" 2> /dev/null
      return "$?"
    fi
  done

  return "$?"
}


# Grab Lyrics from the JSON "API"
# $1 = The Artist
# $2 = The Song
getLyrics()
{
  encodedArtist=$(echo "$1" | tr '[:upper:]' '[:lower:]' | xargs)  # Lowercase the artist, trim whitespaces
  encodedSong=$(echo "$2" | tr '[:upper:]' '[:lower:]'  | xargs)   # Lowercase the song, trim whitespaces
  lyrics="$(FindLyrics "$encodedArtist" "$encodedSong" 2> /dev/null)"
  if [[ $lyrics == "" ]];then { echo "Error: No lyrics found for $1 - $2"; return 1; }; fi
}


printLyrics()
{
  if [[ $filePath == "" ]]; then echo -e "$lyrics"
  else
    if [ -f "$filePath" ]; then
      echo -n "File already exists, do you want to overwrite it [Y/n]: "
      read -r answer
      if [[ "$answer" == [Yy] ]]; then
        echo -e "$lyrics" > "$filePath";
      fi
    else
        echo -e "$lyrics" > "$filePath";
    fi
   fi
}


usage()
{
  cat <<EOF
Lyrics
Description: Fetch lyrics for a certain song.
Usage: lyrics [flags] or lyrics [-a] [arg] [-s] [arg]
Options:
  -a  Artist of the song to fetch lyrics for
  -s  Song of the artist to fetch lyrics for
  -f  Export the lyrics to file rather than outputting to stdout
  -h  Show the help
  -v  Get the tool version
Songs available:
  In The End - Linkin Park
  Yellow - Coldplay
  Rolling in the Deep - Adele
  Bohemian Rhapsody - Queen
  Billie Jean - Michael Jackson
Examples:
   ./lyrics.sh -a Coldplay -s Yellow
   ./lyrics.sh -a Coldplay -s Yellow -f ~/yellowLyrics.txt
EOF
}


while getopts "f:a:s:uvh" opt; do
  case "$opt" in
    \?) echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    h)  usage
        exit 0
        ;;
    v)  echo "Version $currentVersion"
        exit 0
        ;;
    f)
       filePath="$OPTARG"
        ;;
    a)
        artist="true"
        if [[ "$(echo "$@" | grep -Eo "\-s")" == "-s" ]];then song="true";fi # wont go through both options if arg spaced and not quoted this solves that issue (dont need this but once had bug on system where it was necessary)
        if [[ "$(echo "$@" | grep -Eo "\-f")" == "-f" ]];then filePath=$(echo "$@" | grep -Eo "\-f [ a-z A-Z / 0-9 . \ ]*[ -]?" | sed s/-f//g | sed s/-//g | sed s/^" "//g);fi
      ;;
    s)
        song="true"
        if [[ "$(echo "$@" | grep -Eo "\-a")" == "-a" ]];then artist="true";fi # wont go through both options if arg spaced and not quoted this solves that issue (dont need this but once had bug on system where it was necessary)
        if [[ "$(echo "$@" | grep -Eo "\-f")" == "-f" ]];then filePath=$(echo "$@" | grep -Eo "\-f [ a-z A-Z / 0-9 . \ ]*[ -]?" | sed s/-f//g | sed s/-//g | sed s/^" "//g);fi
      ;;
    :)  echo "Option -$OPTARG requires an argument." >&2
        exit 1
        ;;
  esac
done


# special set of first arguments that have a specific behavior across tools
if [[ $# == "0" ]]; then
  usage ## if calling the tool with no flags and args chances are you want to return usage
  exit 0
elif [[ $# == "1" ]]; then
  if [[ $1 == "help" ]]; then
    usage
    exit 0
  fi
fi

if ($artist && ! $song)  || ($song && ! $artist);then
  echo "Error: the -a and the -s flag must be used to fetch lyrics."
  exit 1
elif $artist && $song;then
  song=$(echo "$@" | grep -Eo "\-s [ a-z A-Z 0-9 . \ ]*[ -]?" | sed s/-s//g | sed s/-//g | sed s/^" "//g)
  if [[ $song == "" ]];then { echo "Error: song could not be parsed from input."; exit 1; };fi
  artist=$(echo "$@" | grep -Eo "\-a [ a-z A-Z 0-9 . \ ]*[ -]?" | sed s/-a//g | sed s/-//g | sed s/^" "//g)
  if [[ $artist == "" ]];then { echo "Error: artist could not be parsed from input."; exit 1; };fi
  if [[ $(uname) != "Darwin" ]]; then getConfiguredPython || exit 1;fi
  getLyrics "$artist" "$song" || exit 1
  printLyrics
else
  { clear; echo "You shouldnt be here but maaaaaaybeee you slipped passed me, learn to use the tool!"; sleep 2; clear;}
  usage
  exit 1
fi
