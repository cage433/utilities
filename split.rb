#!/usr/bin/ruby -w

require "shellwords"

if !File.exists?("../combined")
  Dir.mkdir("../combined")
end
file = Dir.glob('*.cue')[0]
lines = IO.readlines(file, :encoding => 'ISO-8859-1')
cd_title = nil
track_titles = []
track_starts = []

cd_file = nil
disc_no = nil

i_current_track = -1
lines.each do |line|
  puts line
  if line =~ /^FILE "(.+)"/
    cd_file = Shellwords.escape($1)
    puts("File #{cd_file}")
  end
  if line =~ /^TITLE "(.+CD(\d\d))"/
    cd_title = Shellwords.escape($1)
    disc_no = $2.to_i
    puts("Title #{cd_title}")
  end
  if line =~ /\s+TITLE "(.+)"/
    track_titles.push($1)
    puts("Track #{$1}")
    i_current_track = i_current_track + 1
  end
  if line =~ /INDEX 0[01] (\d\d):(\d\d):(\d\d)/ && track_starts.size == i_current_track
    min = $1.to_f
    sec = $2.to_f
    frames = $3.to_f
    track_start = sprintf("%d:%02d:%06.3f", min / 60, min % 60, sec + frames / 75)
    track_starts.push(track_start)
    puts("Start #{track_start}")
  end
end

n_tracks = track_titles.size
for i_track in 0...n_tracks
  puts(i_track.to_s)
  to_argument = ""
  if i_track < n_tracks - 1
    to_argument = " -to #{track_starts[i_track + 1]} "
  end
  track_file=Shellwords.escape("#{i_track}. #{track_titles[i_track]}.flac")
  cmd = "ffmpeg -i #{cd_file} -ss #{track_starts[i_track]} #{to_argument} -metadata track=#{i_track + 1} -metadata disc=#{disc_no} -metadata title=#{Shellwords.escape(track_titles[i_track])} ../combined/#{track_file}"
  puts(cmd)
  puts `#{cmd}`
end
