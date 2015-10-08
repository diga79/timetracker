class Project < ActiveRecord::Base
	belongs_to :company
	belongs_to :owner, class_name: "User"
	
    has_many :works
    has_many :users, :through => :works

	validates :name, length: { minimum: 5 }
	validates :company_id, presence: true
    validates :owner_id, presence: true
	validates :default_rate, numericality: { only_integer: true, greater_than: 50, less_than: 1000 }

	validates :slug, length: { minimum: 3 }
	validates :slug, uniqueness: true
	
    scope :lowrate, -> { where("default_rate < 50")}

    def to_s
    	"#{name} (#{company})"
    end


    def self.export_csv(projects)
    	CSV.generate() do |csv|
    		csv << column_names
    		projects.each do |project|
    			csv << project.attributes.values_at(*column_names)
    		end
    	end
    end

    def self.export1_csv(projects)
    	CSV.generate() do |csv|
    		csv << ['name','company','default rate','created_at','owner','most recent work item']
    		projects.each do |project|
    			csv << [
    						project.name,
    						project.company,
    						project.default_rate,
    						project.created_at,
    						project.owner,
    						project.works.order('created_at DESC').first
    					]
    		end
    	end
    end

end