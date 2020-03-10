module RoboHandler

    def compare_updates(lot,lor)
    count = 0
    upd = 0
       0.upto(2) do |index|
             if  lot[index] == lor[index] 
               count += 1
             end
        end
        upd = lot[1].to_i - lor[1].to_i
        if count == 3
            # if equal, returns true and tweet age in hours
            return true,days_old?(lot[3]), upd
        elsif count < 3 
            return false, 0, upd
        else 
            return false, 0, 0
        end
    end

    def days_old?(ts)
        result = (Time.now-Time.parse(ts))/60/60
        return result.to_i
    end

    def build_mail (hm,text)
        hmp = text
        hm += "<li>"+hmp+"</li>"
        puts hmp
        return hm
    end
end