class Usermailer < ApplicationMailer
	#default from: "diga79@gmail.com"

	#sends email to the owner once work hours are created
	def workcreated_email(work)
		@work = work 
		mail(to: work.project.owner.email, subject: "Work Item Created")
	end

	#sends email to the project owner every time, project gets updated
  	def projectupdated_email(project)
    	@project = project
    	mail(to: project.owner.email, subject: "Project Updated")
  	end	
end
