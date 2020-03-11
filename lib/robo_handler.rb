module RoboHandler
  def compare_updates(lot, lor)
    count = 0
    0.upto(2) do |index|
      count += 1 if lot[index] == lor[index]
    end
    upd = lot[1].to_i - lor[1].to_i
    if count == 3
      # if equal, returns true and tweet age in hours
      [true, days_old?(lot[3]), upd]
    elsif count < 3
      [false, 0, upd]
    else
      [false, 0, 0]
    end
  end

  def days_old?(tst)
    result = (Time.now - Time.parse(tst)) / 60 / 60
    result.to_i
  end

  def build_mail(htm, text)
    hmp = text
    htm += '<li>' + hmp + '</li>'
    puts hmp
    htm
  end
end
