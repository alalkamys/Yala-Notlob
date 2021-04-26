class InvitedUsers
    def self.get
        @@the_array ||= []
    end

    def self.add element
        if @@the_array
            @@the_array << element
        else
            @@the_array = [element]
        end
    end

    def self.delete element
        if @@the_array
            @@the_array.delete(element)
        end
    end

    def self.clear
        @@the_array = []
    end
end