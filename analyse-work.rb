#!/usr/bin/ruby -w

$authors=["Alex", "Kennard", "Fox", "Corcoran"]
$start_date="1-Jan-17"

$authors.each do |author|
  author_file = "#{author}-work.txt"
  if File.exist?(author_file)
    File.delete(author_file)
  end
  File.open(author_file, "w+") do |f|

    total_lines_added=0
    total_lines_deleted=0
    total_files_changed=0

    f.puts "Date\tMessage\tHash\tAdded\tDeleted\tChanged\tFiles touched"

    results = `git log upstream/master --author=#{author} --no-merges --date=format:'%F' --format='%ad %h %s' --since='#{$start_date}'`.split("\n")
    results.each do |line|
      if line =~ /\s*([0-9-]+)\s+([A-Za-z0-9]+)\s+(.*)/
        date = $1
        hash = $2
        msg = $3
        scala_changes = `git show --numstat #{hash} | grep '\\.scala$'`.split("\n")
        lines_added=0
        lines_deleted=0
        files_changed=0
        scala_changes.each do |change_line|
          if change_line =~ /\s*(\d+)\s+(\d+).*/
            files_changed += 1
            lines_added += $1.to_i
            lines_deleted += $2.to_i
          else
            raise "bad line #{change_line}"
          end
        end
        f.puts "#{date}\t#{msg}\t#{hash}\t#{lines_added}\t#{lines_deleted}\t#{lines_added + lines_deleted}\t#{files_changed}"
        total_lines_added += lines_added
        total_lines_deleted += lines_deleted
        total_files_changed += files_changed
      else
        raise "Did not match"
      end

    end
    f.puts "Total\t""\t""\t#{total_lines_added}\t#{total_lines_deleted}\t#{total_lines_added + total_lines_deleted}\t#{total_files_changed}"
    puts results[0]
    puts "#{author} #{results.size}"
  end

end
puts "Hi"
