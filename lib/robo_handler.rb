module RoboHandler

    def compare_updates(lot,lor)
    count = 0
    upd = 0
       0.upto(2) do |index|

          #puts ''
          #puts "comparing T: #{lot[index]}  vs R: #{lor[index]}"
             if  lot[index] == lor[index] 
               count += 1
               #print "same element"
             end
        end
        #puts "same elements found #{count}"
        upd = lot[1].to_i - lor[1].to_i
        case count 
        when 3
            # if equal, returns true and tweet age in hours
            return true,days_old?(lot[3]), upd
        when count < 3 
            return false, 0, upd
        else 
            return false, 0, 0
        end
    end

    def days_old?(ts)
        result = (Time.now-Time.parse(ts))/60/60
        return result.to_i
    end

end