class Role < ActiveRecord::Base
    has_many :auditions

    def actors
        self.auditions.map do |a|
            a.actor
        end
    end

    def locations
        self.auditions.map do |a|
            a.location
        end
    end

    def lead
        self.auditions.find(proc {"No actor has been hired for this role"}) {|a| a.hired}
    end

    def understudy
        hired_actors = self.auditions.find_all {|a| a.hired}

        if hired_actors.length >= 2
            hired_actors[1]
        else
            "No actor has been hired for understudy for this role"
        end
    end
end