#!/usr/bin/ruby -w

file = ARGV[0]
lines = IO.readlines(file)
lines = lines.select do |line|
  !line.strip.empty?
end
$date = nil
$message = nil
$files_changed = nil
$insertions = nil
$deletions = nil

$data = []
def add_data()
  if !$date.nil?
    $data.push([$date, $message, $files_changed || 0, $insertions || 0, $deletions || 0])
  end

end
lines.each do |line|
  if line =~ /^(2017-\d\d-\d\d) (.*)$/
    add_data
    $date = $1
    $message = $2.gsub(',', ';')
  else
    if line =~ /(\d+) file(s)? changed/
      $files_changed = $1
    else
      $files_changed = 0
    end
    if line =~ /(\d+) insertion/
      $insertions = $1
    else
      $insertions = 0
    end
    if line =~ /(\d+) deletion/
      $deletions = $1
    else
      $deletions = 0
    end
  end
end
add_data

$data.each do |datum|
  puts datum.map{ |a| a.to_s}.join(", ")
end
