require 'spec_helper'
require 'webmock'


describe Match do

  let(:respons) { JSON.load(Net::HTTP.get(URI('http://www.easports.com/nhl14proclubs/api/xbox/clubs/12345/matches?filters=sum,pretty&matches_returned=500'))) }
  let(:list_item_one) { respons["raw"].first }
    

  it 'gets match data from ea webpage' do
    Match.should_receive(:read_and_add_match_data).with(respons)
    Match.get_matches('matches', '12345')
  end

  it 'reads and adds match data to database' do
#    Match.should_receive(:read_matches).and_return([{test1: 1}, {test2: 2}])
    Match.read_match_data(respons)
  end

  it 'puts game hashes in a list' do
    Match.read_matches(respons)[0][1]["matchId"].should eq "36028797072060554" #list_item_one
  end

  it 'gets out team-data and returns array of team_hashes'  do
    Match.create_team_hash(Match.read_match_data(respons).first[:clubs])
  end
  
  it 'gets player data and return array of player_hashes' do
    Match.create_player_hash(Match.read_match_data(respons).first[:players]).should be "debug"
  end

end
