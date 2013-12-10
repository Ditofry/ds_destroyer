class DsDestroyer

  # Mainly setup instance variables
  def initialize
    # Defaults to home dir
    if ARGV.empty?
      # Set starting path to ~
      @dir = ENV["HOME"] + '/Sites/**/.DS_Store'
    else
      @dir = ARGV[0]
    end
    # Other instance data
    @files      = Dir.glob(@dir);
    @file_count = Dir.glob(@dir).count;
    @fails = []
  end

  def validate_path d    
  end

  def purge
    # Init
    succesfull_deletions = 0

    # Let GLOB do all the work for us
    if @file_count > 0
      @files.each do |f|
        begin
          deleted = File.delete(f);
          succesfull_deletions += 1 if deleted
        rescue => error
          @fails.push(error.message);
        end
      end
    end # if
  
    # Feedback
    puts "#{@file_count} .DS_Store files found"
    puts "#{succesfull_deletions} .DS_Store files deleted"
  end # # purge

  def report_fails
    # Show files that couldn't be deleted
    if @fails.count > 0
      puts "#{@fails.count} fails.  The following files weren't able to be removed:"
      @fails.each do |fail|
        puts fail
      end
    else
      puts 'There were no failed deletion attempts'
    end
  end #report_fails

end

d = DsDestroyer.new
d.purge
d.report_fails