# https://gist.github.com/paulspringett/8802240

require 'pipeline/tasks/base_task'

class Pipeline::AV < Pipeline::BaseTask
  
  Pipeline::Tasks.add self
  
  def initialize(trigger)
  	super(trigger)
    @name = "AV"
    @description = "Test for virus/malware"
    @stage = :file
  end

  def run
    Pipeline.notify "Malware/Virus Check"
  	rootpath = @trigger.path
	  @result=`clamscan --no-summary -i -r "#{rootpath}"`
  end

  def analyze
	  list = @result.split(/\n/)
	  list.each do |v|
	     # v.slice! installdir 
	     Pipeline.notify v
       report "Malicious file identified.", v, @name, :medium
    end
  end

  def supported?
  	# In future, verify tool is available.
  	return true 
  end

end
