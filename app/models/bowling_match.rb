class BowlingMatch < ActiveRecord::Base
  has_many :bowling_teams, :dependent => :delete_all
  has_many :bowling_scores, :dependent => :delete_all
  has_many :users, :through => :bowling_scores

  def import_from_excel(file)
    case File.extname(file.original_filename)
    when '.csv' then Csv.new(file.path, nil, :ignore)
    when '.xls' then import_from_xls(file)
    when '.xlsx' then import_from_xlsx(file)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def import_from_xls(file)
    xls = Roo::Excel.new(file.path, nil, :ignore)
    data = Hash.new { |h,k| h[k] = [] }

    1.upto(xls.last_row) do |row_number|
      user_data = make_user_data_from_row(xls.sheet(0).row(row_number))
      if user_data != nil
        data[user_data["team_name"]] << user_data if user_data["game1_score"] != 0 || user_data["game2_score"] != 0
      end
    end

    data.keys.each do |key|
      bowling_team = BowlingTeam.create(:name => key, :bowling_match_id => self.id)
      self.team_number += 1
      data[key].each do |user_data|
        unless user_data["id"].blank?
          print "------#{user_data["team_name"]}\n"
          print "------#{user_data["player_name"]}\n"
          user_data["id"] = User.find_by_name(user_data["player_name"]).id
        end
        a = BowlingScore.create(:score => user_data["game1_score"], :user_id => user_data["id"],
                            :bowling_match_id => self.id, :bowling_team_id => bowling_team.id,
                            :game_number => 1)
        b = BowlingScore.create(:score => user_data["game2_score"], :user_id => user_data["id"],
                            :bowling_match_id => self.id, :bowling_team_id => bowling_team.id,
                            :game_number => 2)
        c = BowlingTeamMembership.create(:user_id => user_data["id"], :bowling_team_id => bowling_team.id)
        print "---------#{a.id}+#{b.id}*#{c.id}--------------\n"
      end
      bowling_team.calculate_total_score
      bowling_team.calculate_average_score
    end
    self.save
  end

  def import_from_xlsx(file)
    xlsx = Roo::Excelx.new(file.path, nil, :ignore)
  end

  def make_user_data_from_row(row)
    h = Hash.new
    h["team_name"] = row[0]
    return nil if h["team_name"].blank? || h["team_name"] == "#"
    h["player_name"] = row[1]
    return nil if h["player_name"].blank?
    h["id"] = row[2].to_i
    h["hdcp"] = row[3].to_i
    h["game1_score"] = row[4].to_i
    h["game2_score"] = row[5].to_i
    h["participant_p"] = row[6]
    return h
  end
end
