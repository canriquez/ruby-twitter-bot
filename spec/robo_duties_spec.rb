# rubocop:disable Layout/LineLength
require './lib/robo_duties.rb'
require 'time'

RSpec.describe RoboDuties do
  let(:robo_test) { RoboDuties.new }
  let(:lot_ok) { ['1', '10', 'R1D10.Test', '2020-03-11 12:03:54 -0300'] }
  let(:lor_ahead) { ['1', '11', 'R1D11.Learning...'] }
  let(:lor_behind) { ['1', '9', 'R1D9.Learning...'] }
  let(:lor_ok) { ['1', '10', 'R1D10.Test'] }
  let(:html) { '<h2> this is test </>' }
  let(:text) { 'this is message report...' }

  describe '#Compares last-on-twitter vs last-on-repo' do
    it 'Returns [false, 0, -1] : Showing no match between sources and repository ahead of twitter' do
      # time_window = Time.now - Time.parse(lot_ok[3])
      expect(robo_test.compare_updates(lot_ok, lor_ahead)).to eql([false, 0, -1])
    end

    it 'Returns [true, <time - window>, 0] : Showing match between sources. Repository and twitter with same update' do
      time_window = (Time.now - Time.parse(lot_ok[3])) / 60 / 60
      expect(robo_test.compare_updates(lot_ok, lor_ok)).to eql([true, time_window.to_i, 0])
    end

    it 'Returns [false, 0, +1] : EDGE CASE: Showing no match between sources and repository behind twitter' do
      # time_window = Time.now - Time.parse(lot_ok[3])
      expect(robo_test.compare_updates(lot_ok, lor_behind)).to eql([false, 0, 1])
    end
  end

  describe '#Build HTML email markup from robo report text' do
    it '- Test a simple HTML tag creation: should return an aggregated HTML tag' do
      expect(robo_test.build_mail(html, text)).to eql(['<h2> this is test </><li>this is message report...</li>', 'this is message report...'])
    end
  end
end

# rubocop:enable Layout/LineLength
